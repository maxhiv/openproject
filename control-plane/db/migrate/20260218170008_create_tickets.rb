class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :control_plane_project, foreign_key: true
      t.references :isp_site, foreign_key: true
      t.references :reporter, foreign_key: { to_table: :users }
      t.references :assignee, foreign_key: { to_table: :users }
      t.string :subject, null: false
      t.text :description
      t.string :status, default: "open"
      t.string :priority, default: "normal"
      t.string :category
      t.boolean :client_visible, default: false
      t.datetime :sla_due_at
      t.datetime :resolved_at
      t.text :root_cause
      t.text :resolution
      t.jsonb :rca_fields, default: {}
      t.integer :openproject_work_package_id
      t.timestamps
    end
    add_index :tickets, [:organization_id, :status]
    add_index :tickets, :sla_due_at
    add_index :tickets, :openproject_work_package_id
  end
end
