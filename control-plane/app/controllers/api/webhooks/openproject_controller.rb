module Api
  module Webhooks
    class OpenprojectController < ActionController::API
      before_action :verify_webhook_secret

      def receive
        event = params[:action_type] || params[:event] || "unknown"
        payload = params.permit!.to_h

        case event
        when "work_package:created", "work_package:updated"
          handle_work_package_event(payload)
        when "project:updated"
          handle_project_event(payload)
        end

        render json: { status: "ok" }
      end

      private

      def verify_webhook_secret
        expected = ENV["OPENPROJECT_WEBHOOK_SECRET"]
        return unless expected.present?

        provided = request.headers["X-Op-Webhook-Secret"] || params[:webhook_secret]
        unless ActiveSupport::SecurityUtils.secure_compare(provided.to_s, expected)
          render json: { error: "Invalid webhook secret" }, status: :forbidden
        end
      end

      def handle_work_package_event(payload)
        wp = payload.dig("work_package") || {}
        op_project_id = wp.dig("_links", "project", "href")&.split("/")&.last&.to_i
        return unless op_project_id

        project = ControlPlaneProject.find_by(openproject_project_id: op_project_id)
        return unless project

        Rails.logger.info "[Webhook] Work package event for project #{project.id}: #{wp['subject']}"
      end

      def handle_project_event(payload)
        Rails.logger.info "[Webhook] Project event received: #{payload}"
      end
    end
  end
end
