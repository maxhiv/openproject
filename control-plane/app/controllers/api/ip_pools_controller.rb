module Api
  class IpPoolsController < BaseController
    def index
      pools = scope_to_organization(IpPool.all)
      render json: pools.map { |p| pool_json(p) }
    end

    def show
      pool = scope_to_organization(IpPool.all).find(params[:id])
      render json: pool_json(pool, detail: true)
    end

    def create
      require_organization!
      pool = IpPool.new(pool_params)
      pool.organization = @current_organization
      pool.save!
      render json: pool_json(pool), status: :created
    end

    def update
      pool = scope_to_organization(IpPool.all).find(params[:id])
      pool.update!(pool_params)
      render json: pool_json(pool)
    end

    def destroy
      pool = scope_to_organization(IpPool.all).find(params[:id])
      pool.destroy!
      head :no_content
    end

    private

    def pool_params
      params.permit(:name, :network, :prefix_length, :vlan_id, :purpose, :notes, :isp_site_id)
    end

    def pool_json(pool, detail: false)
      json = {
        id: pool.id,
        name: pool.name,
        network: pool.network,
        prefix_length: pool.prefix_length,
        vlan_id: pool.vlan_id,
        purpose: pool.purpose,
        isp_site_id: pool.isp_site_id,
        created_at: pool.created_at
      }
      if detail
        json[:notes] = pool.notes
      end
      json
    end
  end
end
