module Api
  class SessionsController < BaseController
    skip_before_action :authenticate_user!, only: [:create]
    skip_before_action :set_current_organization

    def create
      token = extract_bearer_token
      raise Api::Unauthorized, "Missing Authorization header" unless token

      firebase_payload = FirebaseAuth.verify_id_token(token)
      user = User.find_or_initialize_by(firebase_uid: firebase_payload["sub"])

      if user.new_record?
        user.email = firebase_payload["email"]
        user.display_name = firebase_payload["name"] || firebase_payload["email"]&.split("@")&.first
        user.avatar_url = firebase_payload["picture"]
        user.save!
        audit_login(user, "user_provisioned")
      else
        user.update(last_login_at: Time.current)
        audit_login(user, "login")
      end

      session[:user_id] = user.id
      render json: { user: user_json(user) }, status: :ok
    end

    def destroy
      audit_login(@current_user, "logout") if @current_user
      reset_session
      render json: { message: "Logged out" }, status: :ok
    end

    def me
      render json: { user: user_json(@current_user) }
    end

    private

    def extract_bearer_token
      auth = request.headers["Authorization"]
      return nil unless auth&.start_with?("Bearer ")
      auth.split(" ", 2).last
    end

    def user_json(user)
      {
        id: user.id,
        email: user.email,
        display_name: user.display_name,
        avatar_url: user.avatar_url,
        superadmin: user.superadmin?,
        memberships: user.memberships.includes(:organization).map { |m|
          { organization_id: m.organization_id, organization_name: m.organization.name, role: m.role }
        }
      }
    end

    def audit_login(user, action)
      AuditLog.create(
        user: user,
        action: action,
        details: { ip: request.remote_ip },
        ip_address: request.remote_ip,
        user_agent: request.user_agent
      )
    end
  end
end
