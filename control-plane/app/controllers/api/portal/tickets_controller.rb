module Api
  module Portal
    class TicketsController < BaseController
      before_action :require_client_role

      def index
        tickets = scope_to_organization(Ticket.all).client_visible.order(created_at: :desc)
        render json: tickets.map { |t| portal_ticket_json(t) }
      end

      def show
        ticket = scope_to_organization(Ticket.all).client_visible.find(params[:id])
        render json: portal_ticket_json(ticket, detail: true)
      end

      private

      def portal_ticket_json(ticket, detail: false)
        json = {
          id: ticket.id,
          subject: ticket.subject,
          status: ticket.status,
          priority: ticket.priority,
          created_at: ticket.created_at,
          updated_at: ticket.updated_at
        }
        if detail
          json[:description] = ticket.description
          json[:sla_due_at] = ticket.sla_due_at
          json[:resolved_at] = ticket.resolved_at
        end
        json
      end

      def require_client_role
        return if @current_user&.superadmin?
        require_role!("org_admin", "staff", "client_admin", "client_user", "readonly")
      end
    end
  end
end
