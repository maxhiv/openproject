module Api
  class MembershipsController < BaseController
    before_action :require_admin

    def index
      members = @current_organization.memberships.includes(:user)
      render json: members.map { |m| membership_json(m) }
    end

    def create
      user = User.find_by!(email: params[:email])
      membership = @current_organization.memberships.new(user: user, role: params[:role] || "staff")
      membership.save!
      audit!(action: "member_added", details: { user_id: user.id, role: membership.role })
      render json: membership_json(membership), status: :created
    end

    def update
      membership = @current_organization.memberships.find(params[:id])
      membership.update!(role: params[:role])
      audit!(action: "role_changed", details: { user_id: membership.user_id, new_role: params[:role] })
      render json: membership_json(membership)
    end

    def destroy
      membership = @current_organization.memberships.find(params[:id])
      audit!(action: "member_removed", details: { user_id: membership.user_id })
      membership.destroy!
      head :no_content
    end

    private

    def membership_json(m)
      {
        id: m.id,
        user_id: m.user_id,
        email: m.user.email,
        display_name: m.user.display_name,
        role: m.role,
        active: m.active,
        created_at: m.created_at
      }
    end

    def require_admin
      require_role!("org_admin")
    end
  end
end
