module Api
  class ConstructionPackagesController < BaseController
    def index
      packages = scope_to_organization(ConstructionPackage.all).includes(:construction_milestones)
      render json: packages.map { |p| package_json(p) }
    end

    def show
      package = scope_to_organization(ConstructionPackage.all).find(params[:id])
      render json: package_json(package, detail: true)
    end

    def create
      require_organization!
      package = ConstructionPackage.new(package_params)
      package.organization = @current_organization
      package.save!
      render json: package_json(package), status: :created
    end

    def update
      package = scope_to_organization(ConstructionPackage.all).find(params[:id])
      package.update!(package_params)
      render json: package_json(package)
    end

    def destroy
      package = scope_to_organization(ConstructionPackage.all).find(params[:id])
      package.destroy!
      head :no_content
    end

    private

    def package_params
      params.permit(:name, :description, :status, :wbs_code, :planned_start, :planned_end,
                     :actual_start, :actual_end, :progress_pct, :control_plane_project_id, metadata: {})
    end

    def package_json(package, detail: false)
      json = {
        id: package.id,
        name: package.name,
        status: package.status,
        wbs_code: package.wbs_code,
        progress_pct: package.progress_pct,
        planned_start: package.planned_start,
        planned_end: package.planned_end,
        milestone_count: package.construction_milestones.size,
        created_at: package.created_at
      }
      if detail
        json[:description] = package.description
        json[:actual_start] = package.actual_start
        json[:actual_end] = package.actual_end
        json[:metadata] = package.metadata
        json[:milestones] = package.construction_milestones.order(:sort_order).map { |m|
          { id: m.id, name: m.name, status: m.status, due_date: m.due_date, client_visible: m.client_visible }
        }
      end
      json
    end
  end
end
