class FirebaseAuth
  GOOGLE_CERTS_URL = "https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com"
  ISSUER_PREFIX = "https://securetoken.google.com/"

  class << self
    def verify_id_token(token)
      project_id = ENV.fetch("FIREBASE_PROJECT_ID") { raise Api::Unauthorized, "FIREBASE_PROJECT_ID not configured" }

      header = JWT.decode(token, nil, false).last
      kid = header["kid"]

      certificate = fetch_certificate(kid)
      raise Api::Unauthorized, "Unknown signing key" unless certificate

      payload, = JWT.decode(
        token,
        certificate.public_key,
        true,
        algorithm: "RS256",
        iss: "#{ISSUER_PREFIX}#{project_id}",
        aud: project_id,
        verify_iss: true,
        verify_aud: true,
        verify_iat: true,
        verify_expiration: true
      )

      raise Api::Unauthorized, "Missing subject" if payload["sub"].blank?
      payload
    rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::InvalidIssuerError, JWT::InvalidAudError => e
      raise Api::Unauthorized, "Invalid Firebase token: #{e.message}"
    end

    private

    def fetch_certificate(kid)
      certs = cached_certificates
      return nil unless certs[kid]
      OpenSSL::X509::Certificate.new(certs[kid])
    end

    def cached_certificates
      @certs_expiry ||= Time.at(0)
      if Time.current > @certs_expiry
        response = Net::HTTP.get_response(URI(GOOGLE_CERTS_URL))
        @cached_certs = JSON.parse(response.body)
        cache_control = response["Cache-Control"]
        max_age = cache_control&.match(/max-age=(\d+)/)&.captures&.first&.to_i || 3600
        @certs_expiry = Time.current + max_age
      end
      @cached_certs || {}
    end
  end
end
