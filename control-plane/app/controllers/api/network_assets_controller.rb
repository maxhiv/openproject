module Api
  class NetworkAssetsController < BaseController
    def index
      assets = scope_to_organization(NetworkAsset.all)
      assets = assets.where(asset_type: params[:type]) if params[:type].present?
      assets = assets.where(isp_site_id: params[:site_id]) if params[:site_id].present?
      render json: assets.map { |a| asset_json(a) }
    end

    def show
      asset = scope_to_organization(NetworkAsset.all).find(params[:id])
      render json: asset_json(asset, detail: true)
    end

    def create
      require_organization!
      asset = NetworkAsset.new(asset_params)
      asset.organization = @current_organization
      asset.save!
      render json: asset_json(asset), status: :created
    end

    def update
      asset = scope_to_organization(NetworkAsset.all).find(params[:id])
      asset.update!(asset_params)
      render json: asset_json(asset)
    end

    def destroy
      asset = scope_to_organization(NetworkAsset.all).find(params[:id])
      asset.destroy!
      head :no_content
    end

    private

    def asset_params
      params.permit(:asset_type, :vendor, :model, :serial_number, :ip_address, :mac_address, :location, :status, :isp_site_id, metadata: {})
    end

    def asset_json(asset, detail: false)
      json = {
        id: asset.id,
        asset_type: asset.asset_type,
        vendor: asset.vendor,
        model: asset.model,
        serial_number: asset.serial_number,
        ip_address: asset.ip_address,
        status: asset.status,
        isp_site_id: asset.isp_site_id,
        created_at: asset.created_at
      }
      if detail
        json[:mac_address] = asset.mac_address
        json[:location] = asset.location
        json[:metadata] = asset.metadata
      end
      json
    end
  end
end
