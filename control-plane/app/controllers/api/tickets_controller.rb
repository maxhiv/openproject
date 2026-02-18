module Api
  class TicketsController < BaseController
    def index
      tickets = scope_to_organization(Ticket.all).includes(:reporter, :assignee)
      tickets = tickets.where(status: params[:status]) if params[:status].present?
      tickets = tickets.where(priority: params[:priority]) if params[:priority].present?
      tickets = tickets.client_visible if params[:client_visible] == "true"
      render json: tickets.order(created_at: :desc).map { |t| ticket_json(t) }
    end

    def show
      ticket = scope_to_organization(Ticket.all).find(params[:id])
      render json: ticket_json(ticket, detail: true)
    end

    def create
      require_organization!
      ticket = Ticket.new(ticket_params)
      ticket.organization = @current_organization
      ticket.reporter = @current_user
      ticket.save!
      render json: ticket_json(ticket), status: :created
    end

    def update
      ticket = scope_to_organization(Ticket.all).find(params[:id])
      ticket.update!(ticket_params)
      render json: ticket_json(ticket)
    end

    def destroy
      ticket = scope_to_organization(Ticket.all).find(params[:id])
      ticket.destroy!
      head :no_content
    end

    private

    def ticket_params
      params.permit(:subject, :description, :status, :priority, :category, :client_visible,
                     :sla_due_at, :assignee_id, :isp_site_id, :control_plane_project_id,
                     :root_cause, :resolution, rca_fields: {})
    end

    def ticket_json(ticket, detail: false)
      json = {
        id: ticket.id,
        subject: ticket.subject,
        status: ticket.status,
        priority: ticket.priority,
        client_visible: ticket.client_visible,
        reporter: ticket.reporter&.display_name,
        assignee: ticket.assignee&.display_name,
        sla_due_at: ticket.sla_due_at,
        created_at: ticket.created_at,
        updated_at: ticket.updated_at
      }
      if detail
        json[:description] = ticket.description
        json[:category] = ticket.category
        json[:root_cause] = ticket.root_cause
        json[:resolution] = ticket.resolution
        json[:rca_fields] = ticket.rca_fields
        json[:isp_site_id] = ticket.isp_site_id
        json[:control_plane_project_id] = ticket.control_plane_project_id
        json[:openproject_work_package_id] = ticket.openproject_work_package_id
      end
      json
    end
  end
end
