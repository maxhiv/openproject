# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_02_18_170014) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "audit_logs", force: :cascade do |t|
    t.string "action", null: false
    t.datetime "created_at", null: false
    t.jsonb "details", default: {}
    t.string "ip_address"
    t.bigint "organization_id"
    t.string "user_agent"
    t.bigint "user_id"
    t.index ["action"], name: "index_audit_logs_on_action"
    t.index ["created_at"], name: "index_audit_logs_on_created_at"
    t.index ["organization_id"], name: "index_audit_logs_on_organization_id"
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "change_requests", force: :cascade do |t|
    t.datetime "approved_at"
    t.bigint "approver_id"
    t.datetime "completed_at"
    t.bigint "control_plane_project_id"
    t.datetime "created_at", null: false
    t.text "description"
    t.text "impact_assessment"
    t.jsonb "impacted_asset_ids", default: []
    t.jsonb "impacted_site_ids", default: []
    t.datetime "maintenance_window_end"
    t.datetime "maintenance_window_start"
    t.integer "openproject_work_package_id"
    t.bigint "organization_id", null: false
    t.string "priority", default: "normal"
    t.bigint "requester_id"
    t.text "rollback_plan"
    t.string "status", default: "draft"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["approver_id"], name: "index_change_requests_on_approver_id"
    t.index ["control_plane_project_id"], name: "index_change_requests_on_control_plane_project_id"
    t.index ["organization_id", "status"], name: "index_change_requests_on_organization_id_and_status"
    t.index ["organization_id"], name: "index_change_requests_on_organization_id"
    t.index ["requester_id"], name: "index_change_requests_on_requester_id"
  end

  create_table "construction_milestones", force: :cascade do |t|
    t.bigint "approved_by_id"
    t.datetime "client_approved_at"
    t.boolean "client_visible", default: false
    t.date "completed_date"
    t.bigint "construction_package_id", null: false
    t.datetime "created_at", null: false
    t.jsonb "dependencies", default: []
    t.text "description"
    t.date "due_date"
    t.string "name", null: false
    t.integer "openproject_work_package_id"
    t.bigint "organization_id", null: false
    t.boolean "requires_client_approval", default: false
    t.integer "sort_order", default: 0
    t.string "status", default: "pending"
    t.datetime "updated_at", null: false
    t.index ["approved_by_id"], name: "index_construction_milestones_on_approved_by_id"
    t.index ["construction_package_id"], name: "index_construction_milestones_on_construction_package_id"
    t.index ["openproject_work_package_id"], name: "index_construction_milestones_on_openproject_work_package_id"
    t.index ["organization_id"], name: "index_construction_milestones_on_organization_id"
  end

  create_table "construction_packages", force: :cascade do |t|
    t.date "actual_end"
    t.date "actual_start"
    t.bigint "control_plane_project_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.jsonb "metadata", default: {}
    t.string "name", null: false
    t.bigint "organization_id", null: false
    t.date "planned_end"
    t.date "planned_start"
    t.decimal "progress_pct", precision: 5, scale: 2, default: "0.0"
    t.string "status", default: "planning"
    t.datetime "updated_at", null: false
    t.string "wbs_code"
    t.index ["control_plane_project_id"], name: "index_construction_packages_on_control_plane_project_id"
    t.index ["organization_id"], name: "index_construction_packages_on_organization_id"
  end

  create_table "control_plane_projects", force: :cascade do |t|
    t.boolean "client_portal_enabled", default: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "identifier", null: false
    t.string "name", null: false
    t.integer "openproject_project_id"
    t.bigint "organization_id", null: false
    t.jsonb "settings", default: {}
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_control_plane_projects_on_identifier", unique: true
    t.index ["openproject_project_id"], name: "index_control_plane_projects_on_openproject_project_id"
    t.index ["organization_id"], name: "index_control_plane_projects_on_organization_id"
  end

  create_table "ip_pools", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "isp_site_id"
    t.string "name", null: false
    t.string "network", null: false
    t.text "notes"
    t.bigint "organization_id", null: false
    t.integer "prefix_length", null: false
    t.string "purpose"
    t.datetime "updated_at", null: false
    t.integer "vlan_id"
    t.index ["isp_site_id"], name: "index_ip_pools_on_isp_site_id"
    t.index ["organization_id", "vlan_id"], name: "index_ip_pools_on_organization_id_and_vlan_id"
    t.index ["organization_id"], name: "index_ip_pools_on_organization_id"
  end

  create_table "isp_sites", force: :cascade do |t|
    t.text "address"
    t.bigint "control_plane_project_id"
    t.datetime "created_at", null: false
    t.decimal "latitude", precision: 10, scale: 7
    t.decimal "longitude", precision: 10, scale: 7
    t.jsonb "metadata", default: {}
    t.string "name", null: false
    t.text "notes"
    t.bigint "organization_id", null: false
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
    t.index ["control_plane_project_id"], name: "index_isp_sites_on_control_plane_project_id"
    t.index ["organization_id", "name"], name: "index_isp_sites_on_organization_id_and_name"
    t.index ["organization_id"], name: "index_isp_sites_on_organization_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.bigint "organization_id", null: false
    t.string "role", default: "staff", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["user_id", "organization_id"], name: "index_memberships_on_user_id_and_organization_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "network_assets", force: :cascade do |t|
    t.string "asset_type", null: false
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.bigint "isp_site_id"
    t.string "location"
    t.string "mac_address"
    t.jsonb "metadata", default: {}
    t.string "model"
    t.bigint "organization_id", null: false
    t.string "serial_number"
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
    t.string "vendor"
    t.index ["asset_type"], name: "index_network_assets_on_asset_type"
    t.index ["isp_site_id"], name: "index_network_assets_on_isp_site_id"
    t.index ["organization_id", "asset_type"], name: "index_network_assets_on_organization_id_and_asset_type"
    t.index ["organization_id"], name: "index_network_assets_on_organization_id"
    t.index ["serial_number"], name: "index_network_assets_on_serial_number"
  end

  create_table "organizations", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "plan", default: "free"
    t.jsonb "settings", default: {}
    t.string "slug", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "permits", force: :cascade do |t|
    t.date "approved_date"
    t.jsonb "checklist", default: []
    t.bigint "control_plane_project_id", null: false
    t.datetime "created_at", null: false
    t.date "expiry_date"
    t.string "jurisdiction"
    t.text "notes"
    t.bigint "organization_id", null: false
    t.string "permit_number"
    t.string "permit_type", null: false
    t.string "status", default: "pending"
    t.date "submitted_date"
    t.datetime "updated_at", null: false
    t.index ["control_plane_project_id"], name: "index_permits_on_control_plane_project_id"
    t.index ["organization_id"], name: "index_permits_on_organization_id"
  end

  create_table "procurement_items", force: :cascade do |t|
    t.date "actual_delivery_date"
    t.bigint "construction_package_id"
    t.bigint "control_plane_project_id"
    t.datetime "created_at", null: false
    t.text "description"
    t.date "expected_delivery_date"
    t.integer "lead_time_days"
    t.string "name", null: false
    t.text "notes"
    t.date "order_date"
    t.bigint "organization_id", null: false
    t.string "part_number"
    t.integer "quantity", default: 1
    t.string "status", default: "pending"
    t.decimal "unit_cost", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.string "vendor"
    t.index ["construction_package_id"], name: "index_procurement_items_on_construction_package_id"
    t.index ["control_plane_project_id"], name: "index_procurement_items_on_control_plane_project_id"
    t.index ["organization_id"], name: "index_procurement_items_on_organization_id"
  end

  create_table "project_snapshots", force: :cascade do |t|
    t.bigint "control_plane_project_id", null: false
    t.datetime "created_at", null: false
    t.string "label"
    t.bigint "organization_id", null: false
    t.jsonb "snapshot_data", default: {}
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["control_plane_project_id"], name: "index_project_snapshots_on_control_plane_project_id"
    t.index ["organization_id"], name: "index_project_snapshots_on_organization_id"
    t.index ["user_id"], name: "index_project_snapshots_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "assignee_id"
    t.string "category"
    t.boolean "client_visible", default: false
    t.bigint "control_plane_project_id"
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "isp_site_id"
    t.integer "openproject_work_package_id"
    t.bigint "organization_id", null: false
    t.string "priority", default: "normal"
    t.jsonb "rca_fields", default: {}
    t.bigint "reporter_id"
    t.text "resolution"
    t.datetime "resolved_at"
    t.text "root_cause"
    t.datetime "sla_due_at"
    t.string "status", default: "open"
    t.string "subject", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tickets_on_assignee_id"
    t.index ["control_plane_project_id"], name: "index_tickets_on_control_plane_project_id"
    t.index ["isp_site_id"], name: "index_tickets_on_isp_site_id"
    t.index ["openproject_work_package_id"], name: "index_tickets_on_openproject_work_package_id"
    t.index ["organization_id", "status"], name: "index_tickets_on_organization_id_and_status"
    t.index ["organization_id"], name: "index_tickets_on_organization_id"
    t.index ["reporter_id"], name: "index_tickets_on_reporter_id"
    t.index ["sla_due_at"], name: "index_tickets_on_sla_due_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.string "display_name"
    t.string "email", null: false
    t.string "firebase_uid", null: false
    t.datetime "last_login_at"
    t.boolean "superadmin", default: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["firebase_uid"], name: "index_users_on_firebase_uid", unique: true
  end

  add_foreign_key "audit_logs", "organizations"
  add_foreign_key "audit_logs", "users"
  add_foreign_key "change_requests", "control_plane_projects"
  add_foreign_key "change_requests", "organizations"
  add_foreign_key "change_requests", "users", column: "approver_id"
  add_foreign_key "change_requests", "users", column: "requester_id"
  add_foreign_key "construction_milestones", "construction_packages"
  add_foreign_key "construction_milestones", "organizations"
  add_foreign_key "construction_milestones", "users", column: "approved_by_id"
  add_foreign_key "construction_packages", "control_plane_projects"
  add_foreign_key "construction_packages", "organizations"
  add_foreign_key "control_plane_projects", "organizations"
  add_foreign_key "ip_pools", "isp_sites"
  add_foreign_key "ip_pools", "organizations"
  add_foreign_key "isp_sites", "control_plane_projects"
  add_foreign_key "isp_sites", "organizations"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
  add_foreign_key "network_assets", "isp_sites"
  add_foreign_key "network_assets", "organizations"
  add_foreign_key "permits", "control_plane_projects"
  add_foreign_key "permits", "organizations"
  add_foreign_key "procurement_items", "construction_packages"
  add_foreign_key "procurement_items", "control_plane_projects"
  add_foreign_key "procurement_items", "organizations"
  add_foreign_key "project_snapshots", "control_plane_projects"
  add_foreign_key "project_snapshots", "organizations"
  add_foreign_key "project_snapshots", "users"
  add_foreign_key "tickets", "control_plane_projects"
  add_foreign_key "tickets", "isp_sites"
  add_foreign_key "tickets", "organizations"
  add_foreign_key "tickets", "users", column: "assignee_id"
  add_foreign_key "tickets", "users", column: "reporter_id"
end
