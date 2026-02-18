module Api
  class ProcurementItemsController < BaseController
    def index
      items = scope_to_organization(ProcurementItem.all)
      items = items.where(status: params[:status]) if params[:status].present?
      render json: items.map { |i| item_json(i) }
    end

    def show
      item = scope_to_organization(ProcurementItem.all).find(params[:id])
      render json: item_json(item, detail: true)
    end

    def create
      require_organization!
      item = ProcurementItem.new(item_params)
      item.organization = @current_organization
      item.save!
      render json: item_json(item), status: :created
    end

    def update
      item = scope_to_organization(ProcurementItem.all).find(params[:id])
      item.update!(item_params)
      render json: item_json(item)
    end

    def destroy
      item = scope_to_organization(ProcurementItem.all).find(params[:id])
      item.destroy!
      head :no_content
    end

    private

    def item_params
      params.permit(:name, :description, :vendor, :part_number, :quantity, :unit_cost,
                     :status, :lead_time_days, :order_date, :expected_delivery_date,
                     :actual_delivery_date, :notes, :control_plane_project_id, :construction_package_id)
    end

    def item_json(item, detail: false)
      json = {
        id: item.id,
        name: item.name,
        vendor: item.vendor,
        status: item.status,
        quantity: item.quantity,
        unit_cost: item.unit_cost,
        expected_delivery_date: item.expected_delivery_date,
        created_at: item.created_at
      }
      if detail
        json[:description] = item.description
        json[:part_number] = item.part_number
        json[:lead_time_days] = item.lead_time_days
        json[:order_date] = item.order_date
        json[:actual_delivery_date] = item.actual_delivery_date
        json[:notes] = item.notes
      end
      json
    end
  end
end
