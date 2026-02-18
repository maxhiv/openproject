module Api
  class ProjectsController < BaseController
    before_action :require_staff_or_above, only: [:create, :update, :destroy]

    def index
      projects = scope_to_organization(ControlPlaneProject.all)
      render json: projects.map { |p| project_json(p) }
    end

    def show
      project = scope_to_organization(ControlPlaneProject.all).find(params[:id])
      render json: project_json(project, detail: true)
    end

    def create
      project = @current_organization.control_plane_projects.new(project_params)
      project.save!

      if params[:sync_openproject]
        sync_to_openproject(project)
      end

      audit!(action: "project_created", details: { project_id: project.id, name: project.name })
      render json: project_json(project), status: :created
    end

    def update
      project = scope_to_organization(ControlPlaneProject.all).find(params[:id])
      project.update!(project_params)
      render json: project_json(project)
    end

    def destroy
      project = scope_to_organization(ControlPlaneProject.all).find(params[:id])
      project.destroy!
      head :no_content
    end

    private

    def project_params
      params.permit(:name, :identifier, :description, :status, :client_portal_enabled, settings: {})
    end

    def project_json(project, detail: false)
      json = {
        id: project.id,
        name: project.name,
        identifier: project.identifier,
        description: project.description,
        status: project.status,
        openproject_project_id: project.openproject_project_id,
        client_portal_enabled: project.client_portal_enabled,
        created_at: project.created_at
      }
      if detail
        json[:ticket_count] = project.tickets.count
        json[:milestone_count] = project.construction_milestones.count
        json[:package_count] = project.construction_packages.count
      end
      json
    end

    def sync_to_openproject(project)
      client = OpenprojectClient.new
      result = client.create_project(
        name: project.name,
        identifier: project.identifier,
        description: project.description || ""
      )
      project.update!(openproject_project_id: result["id"])
    rescue => e
      Rails.logger.error "[OpenProject Sync] Failed: #{e.message}"
    end

    def require_staff_or_above
      require_role!("org_admin", "staff")
    end
  end
end
