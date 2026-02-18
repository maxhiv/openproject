class OpenprojectClient
  attr_reader :connection

  def initialize
    @base_url = ENV.fetch("OPENPROJECT_URL", "http://localhost:5000")
    @api_token = ENV.fetch("OPENPROJECT_API_TOKEN", "")

    @connection = Faraday.new(url: @base_url) do |f|
      f.request :json
      f.response :json
      f.request :retry, max: 2, interval: 0.5
      f.headers["Authorization"] = "Basic #{Base64.strict_encode64("apikey:#{@api_token}")}"
      f.headers["Content-Type"] = "application/json"
    end
  end

  def create_project(name:, identifier:, description: "")
    response = connection.post("/api/v3/projects") do |req|
      req.body = {
        name: name,
        identifier: identifier,
        description: { format: "markdown", raw: description },
        public: false
      }
    end
    handle_response(response)
  end

  def get_project(id)
    response = connection.get("/api/v3/projects/#{id}")
    handle_response(response)
  end

  def create_work_package(project_id:, subject:, type: "Task", description: "", assignee_id: nil)
    body = {
      subject: subject,
      description: { format: "markdown", raw: description },
      _links: {
        type: { href: "/api/v3/types/#{type_id_for(type)}" },
        project: { href: "/api/v3/projects/#{project_id}" }
      }
    }
    body[:_links][:assignee] = { href: "/api/v3/users/#{assignee_id}" } if assignee_id

    response = connection.post("/api/v3/projects/#{project_id}/work_packages") do |req|
      req.body = body
    end
    handle_response(response)
  end

  def update_work_package(id, attributes)
    response = connection.patch("/api/v3/work_packages/#{id}") do |req|
      req.body = attributes
    end
    handle_response(response)
  end

  def get_work_package(id)
    response = connection.get("/api/v3/work_packages/#{id}")
    handle_response(response)
  end

  def list_work_packages(project_id, filters: [])
    query_params = filters.any? ? "?filters=#{URI.encode_www_form_component(filters.to_json)}" : ""
    response = connection.get("/api/v3/projects/#{project_id}/work_packages#{query_params}")
    handle_response(response)
  end

  private

  def handle_response(response)
    case response.status
    when 200..299
      response.body
    when 401
      raise "OpenProject authentication failed"
    when 403
      raise "OpenProject permission denied"
    when 404
      raise ActiveRecord::RecordNotFound, "OpenProject resource not found"
    else
      raise "OpenProject API error (#{response.status}): #{response.body}"
    end
  end

  def type_id_for(name)
    @type_cache ||= {}
    @type_cache[name] ||= begin
      resp = connection.get("/api/v3/types")
      types = resp.body["_embedded"]["elements"] rescue []
      found = types.find { |t| t["name"].downcase == name.downcase }
      found ? found["id"] : 1
    end
  end
end
