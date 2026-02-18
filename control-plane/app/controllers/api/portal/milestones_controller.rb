module Api
  module Portal
    class MilestonesController < BaseController
      before_action :require_client_role

      def index
        milestones = scope_to_organization(ConstructionMilestone.all).client_visible
        render json: milestones.map { |m| milestone_json(m) }
      end

      def show
        milestone = scope_to_organization(ConstructionMilestone.all).client_visible.find(params[:id])
        render json: milestone_json(milestone, detail: true)
      end

      def approve
        milestone = scope_to_organization(ConstructionMilestone.all)
          .where(requires_client_approval: true, client_approved_at: nil)
          .find(params[:id])

        milestone.update!(
          client_approved_at: Time.current,
          approved_by: @current_user,
          status: "approved"
        )
        audit!(action: "milestone_approved", details: { milestone_id: milestone.id })
        render json: milestone_json(milestone)
      end

      private

      def milestone_json(milestone, detail: false)
        json = {
          id: milestone.id,
          name: milestone.name,
          status: milestone.status,
          due_date: milestone.due_date,
          completed_date: milestone.completed_date,
          requires_approval: milestone.requires_client_approval,
          approved_at: milestone.client_approved_at
        }
        if detail
          json[:description] = milestone.description
          json[:package_name] = milestone.construction_package&.name
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
