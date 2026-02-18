module Api
  class OrganizationsController < BaseController
    skip_before_action :set_current_organization

    def index
      if @current_user.superadmin?
        orgs = Organization.all
      else
        orgs = @current_user.organizations
      end
      render json: orgs.map { |o| org_json(o) }
    end

    def show
      org = Organization.find(params[:id])
      authorize_org!(org)
      render json: org_json(org)
    end

    def create
      require_superadmin_or_no_orgs!
      org = Organization.new(org_params)
      org.save!
      Membership.create!(user: @current_user, organization: org, role: "org_admin")
      audit!(action: "organization_created", details: { organization_id: org.id, name: org.name })
      render json: org_json(org), status: :created
    end

    def update
      org = Organization.find(params[:id])
      authorize_org!(org, admin: true)
      org.update!(org_params)
      render json: org_json(org)
    end

    private

    def org_params
      params.permit(:name, :slug, :plan, :active, settings: {})
    end

    def org_json(org)
      {
        id: org.id,
        name: org.name,
        slug: org.slug,
        plan: org.plan,
        active: org.active,
        member_count: org.memberships.count,
        project_count: org.control_plane_projects.count,
        created_at: org.created_at
      }
    end

    def authorize_org!(org, admin: false)
      return if @current_user.superadmin?
      membership = @current_user.memberships.find_by(organization: org)
      raise Api::Forbidden, "Not a member" unless membership
      raise Api::Forbidden, "Admin required" if admin && !%w[org_admin].include?(membership.role)
    end

    def require_superadmin_or_no_orgs!
      return if @current_user.superadmin?
      return if @current_user.organizations.empty?
      raise Api::Forbidden, "Only superadmins or users without organizations can create new organizations"
    end
  end
end
