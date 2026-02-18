module Api
  class ChangeRequestsController < BaseController
    def index
      crs = scope_to_organization(ChangeRequest.all).includes(:requester, :approver)
      crs = crs.where(status: params[:status]) if params[:status].present?
      render json: crs.order(created_at: :desc).map { |cr| cr_json(cr) }
    end

    def show
      cr = scope_to_organization(ChangeRequest.all).find(params[:id])
      render json: cr_json(cr, detail: true)
    end

    def create
      require_organization!
      cr = ChangeRequest.new(cr_params)
      cr.organization = @current_organization
      cr.requester = @current_user
      cr.save!
      render json: cr_json(cr), status: :created
    end

    def update
      cr = scope_to_organization(ChangeRequest.all).find(params[:id])
      old_status = cr.status
      cr.update!(cr_params)
      if cr.status == "approved" && old_status != "approved"
        cr.update!(approved_at: Time.current, approver: @current_user)
        audit!(action: "change_request_approved", details: { cr_id: cr.id })
      end
      render json: cr_json(cr)
    end

    def destroy
      cr = scope_to_organization(ChangeRequest.all).find(params[:id])
      cr.destroy!
      head :no_content
    end

    private

    def cr_params
      params.permit(:title, :description, :status, :priority, :maintenance_window_start,
                     :maintenance_window_end, :rollback_plan, :impact_assessment,
                     :control_plane_project_id, impacted_site_ids: [], impacted_asset_ids: [])
    end

    def cr_json(cr, detail: false)
      json = {
        id: cr.id,
        title: cr.title,
        status: cr.status,
        priority: cr.priority,
        requester: cr.requester&.display_name,
        approver: cr.approver&.display_name,
        maintenance_window_start: cr.maintenance_window_start,
        maintenance_window_end: cr.maintenance_window_end,
        approved_at: cr.approved_at,
        created_at: cr.created_at
      }
      if detail
        json[:description] = cr.description
        json[:rollback_plan] = cr.rollback_plan
        json[:impact_assessment] = cr.impact_assessment
        json[:impacted_site_ids] = cr.impacted_site_ids
        json[:impacted_asset_ids] = cr.impacted_asset_ids
        json[:control_plane_project_id] = cr.control_plane_project_id
      end
      json
    end
  end
end
