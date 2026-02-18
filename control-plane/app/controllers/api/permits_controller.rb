module Api
  class PermitsController < BaseController
    def index
      permits = scope_to_organization(Permit.all)
      render json: permits.map { |p| permit_json(p) }
    end

    def show
      permit = scope_to_organization(Permit.all).find(params[:id])
      render json: permit_json(permit, detail: true)
    end

    def create
      require_organization!
      permit = Permit.new(permit_params)
      permit.organization = @current_organization
      permit.save!
      render json: permit_json(permit), status: :created
    end

    def update
      permit = scope_to_organization(Permit.all).find(params[:id])
      permit.update!(permit_params)
      render json: permit_json(permit)
    end

    def destroy
      permit = scope_to_organization(Permit.all).find(params[:id])
      permit.destroy!
      head :no_content
    end

    private

    def permit_params
      params.permit(:permit_type, :jurisdiction, :permit_number, :status,
                     :submitted_date, :approved_date, :expiry_date, :notes,
                     :control_plane_project_id, checklist: [])
    end

    def permit_json(permit, detail: false)
      json = {
        id: permit.id,
        permit_type: permit.permit_type,
        status: permit.status,
        jurisdiction: permit.jurisdiction,
        permit_number: permit.permit_number,
        submitted_date: permit.submitted_date,
        approved_date: permit.approved_date,
        created_at: permit.created_at
      }
      if detail
        json[:expiry_date] = permit.expiry_date
        json[:notes] = permit.notes
        json[:checklist] = permit.checklist
      end
      json
    end
  end
end
