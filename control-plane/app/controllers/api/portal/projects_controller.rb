module Api
  module Portal
    class ProjectsController < BaseController
      before_action :require_client_role

      def index
        projects = client_projects.where(client_portal_enabled: true)
        render json: projects.map { |p| portal_project_json(p) }
      end

      def show
        project = client_projects.where(client_portal_enabled: true).find(params[:id])
        render json: portal_project_json(project, detail: true)
      end

      private

      def client_projects
        scope_to_organization(ControlPlaneProject.all)
      end

      def portal_project_json(project, detail: false)
        json = {
          id: project.id,
          name: project.name,
          status: project.status,
          created_at: project.created_at
        }
        if detail
          json[:description] = project.description
          json[:milestones] = project.construction_milestones.client_visible.map { |m|
            { id: m.id, name: m.name, status: m.status, due_date: m.due_date }
          }
          json[:tickets] = project.tickets.client_visible.map { |t|
            { id: t.id, subject: t.subject, status: t.status, priority: t.priority }
          }
        end
        json
      end

      def require_client_role
        return if @current_user&.superadmin?
        require_role!("org_admin", "staff", "client_admin", "client_user", "readonly")
      end
    end
  end
end
