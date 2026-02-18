class CreateChangeRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :change_requests do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :control_plane_project, foreign_key: true
      t.references :requester, foreign_key: { to_table: :users }
      t.references :approver, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.text :description
      t.string :status, default: "draft"
      t.string :priority, default: "normal"
      t.datetime :maintenance_window_start
      t.datetime :maintenance_window_end
      t.text :rollback_plan
      t.text :impact_assessment
      t.jsonb :impacted_site_ids, default: []
      t.jsonb :impacted_asset_ids, default: []
      t.datetime :approved_at
      t.datetime :completed_at
      t.integer :openproject_work_package_id
      t.timestamps
    end
    add_index :change_requests, [:organization_id, :status]
  end
end
