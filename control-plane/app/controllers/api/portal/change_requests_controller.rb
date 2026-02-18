module Api
  module Portal
    class ChangeRequestsController < BaseController
      before_action :require_client_role

      def index
        crs = scope_to_organization(ChangeRequest.all)
          .where(status: %w[pending_approval approved in_progress completed])
          .order(created_at: :desc)
        render json: crs.map { |cr| portal_cr_json(cr) }
      end

      def show
        cr = scope_to_organization(ChangeRequest.all).find(params[:id])
        render json: portal_cr_json(cr, detail: true)
      end

      def approve
        require_role!("client_admin", "org_admin")
        cr = scope_to_organization(ChangeRequest.all)
          .where(status: "pending_approval")
          .find(params[:id])

        cr.update!(
          status: "approved",
          approved_at: Time.current,
          approver: @current_user
        )
        audit!(action: "change_request_client_approved", details: { cr_id: cr.id })
        render json: portal_cr_json(cr)
      end

      private

      def portal_cr_json(cr, detail: false)
        json = {
          id: cr.id,
          title: cr.title,
          status: cr.status,
          priority: cr.priority,
          maintenance_window_start: cr.maintenance_window_start,
          maintenance_window_end: cr.maintenance_window_end,
          approved_at: cr.approved_at,
          created_at: cr.created_at
        }
        if detail
          json[:description] = cr.description
          json[:impact_assessment] = cr.impact_assessment
          json[:rollback_plan] = cr.rollback_plan
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
