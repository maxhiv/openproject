module Api
  class BaseController < ActionController::API
    include ActionController::Cookies

    before_action :authenticate_user!
    before_action :set_current_organization

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable
    rescue_from Api::Unauthorized, with: :unauthorized
    rescue_from Api::Forbidden, with: :forbidden

    private

    def authenticate_user!
      @current_user = current_user_from_session
      raise Api::Unauthorized, "Authentication required" unless @current_user
    end

    def current_user_from_session
      return nil unless session[:user_id]
      User.find_by(id: session[:user_id])
    end

    def set_current_organization
      org_id = params[:organization_id] || request.headers["X-Organization-Id"]
      if org_id.present?
        @current_organization = Organization.find(org_id)
        membership = @current_user&.memberships&.find_by(organization: @current_organization)
        raise Api::Forbidden, "Not a member of this organization" unless membership || @current_user&.superadmin?
        @current_membership = membership
      elsif !@current_user&.superadmin?
        default_membership = @current_user&.memberships&.active&.first
        if default_membership
          @current_organization = default_membership.organization
          @current_membership = default_membership
        end
      end
    end

    def require_role!(*roles)
      return if @current_user&.superadmin?
      unless @current_membership && roles.map(&:to_s).include?(@current_membership.role)
        raise Api::Forbidden, "Insufficient permissions"
      end
    end

    def require_organization!
      raise Api::Forbidden, "Organization context required" unless @current_organization
    end

    def scope_to_organization(relation)
      if @current_organization
        relation.where(organization: @current_organization)
      elsif @current_user&.superadmin?
        relation
      else
        org_ids = @current_user.memberships.pluck(:organization_id)
        relation.where(organization_id: org_ids)
      end
    end

    def audit!(action:, details: {})
      AuditLog.create!(
        user: @current_user,
        organization: @current_organization,
        action: action,
        details: details,
        ip_address: request.remote_ip,
        user_agent: request.user_agent
      )
    end

    def not_found
      render json: { error: "Not found" }, status: :not_found
    end

    def unprocessable(exception)
      render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

    def unauthorized(exception)
      render json: { error: exception.message }, status: :unauthorized
    end

    def forbidden(exception)
      render json: { error: exception.message }, status: :forbidden
    end
  end
end
