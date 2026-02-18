Rails.application.config.after_initialize do
  EnterpriseToken.class_eval do
    class << self
      def allows_to?(_feature)
        true
      end

      def active?
        true
      end

      def show_banners?
        false
      end

      def hide_banners?
        true
      end

      def trial_only?
        false
      end

      def available_features
        Set.new(%i[
          board_view
          team_planner_view
          baseline_comparison
          work_package_sharing
          work_package_query_relation_columns
          placeholder_users
          custom_field_hierarchies
          date_alerts
          gantt_pdf_export
          readonly_work_packages
          define_custom_style
          internal_comments
          virus_scanning
          capture_external_links
          one_drive_sharepoint_file_storage
          nextcloud_sso
          ldap_groups
          sso_auth_providers
          scim_api
          mcp_server
          portfolio_management
          customize_life_cycle
          calculated_values
          work_package_subject_generation
          time_entry_time_restrictions
        ])
      end

      def trialling_features
        Set.new
      end

      def trialling?(_feature)
        false
      end
    end
  end
end
