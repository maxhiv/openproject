module Api
  class IspSitesController < BaseController
    def index
      sites = scope_to_organization(IspSite.all).includes(:network_assets)
      render json: sites.map { |s| site_json(s) }
    end

    def show
      site = scope_to_organization(IspSite.all).find(params[:id])
      render json: site_json(site, detail: true)
    end

    def create
      require_organization!
      site = IspSite.new(site_params)
      site.organization = @current_organization
      site.save!
      render json: site_json(site), status: :created
    end

    def update
      site = scope_to_organization(IspSite.all).find(params[:id])
      site.update!(site_params)
      render json: site_json(site)
    end

    def destroy
      site = scope_to_organization(IspSite.all).find(params[:id])
      site.destroy!
      head :no_content
    end

    private

    def site_params
      params.permit(:name, :address, :latitude, :longitude, :notes, :status, :control_plane_project_id, metadata: {})
    end

    def site_json(site, detail: false)
      json = {
        id: site.id,
        organization_id: site.organization_id,
        name: site.name,
        address: site.address,
        latitude: site.latitude,
        longitude: site.longitude,
        status: site.status,
        asset_count: site.network_assets.size,
        created_at: site.created_at
      }
      if detail
        json[:notes] = site.notes
        json[:metadata] = site.metadata
        json[:network_assets] = site.network_assets.map { |a| { id: a.id, asset_type: a.asset_type, vendor: a.vendor, model: a.model, status: a.status } }
      end
      json
    end
  end
end
