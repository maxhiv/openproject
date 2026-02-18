class CreateControlPlaneProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :control_plane_projects do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.string :identifier, null: false
      t.text :description
      t.string :status, default: "active"
      t.integer :openproject_project_id
      t.jsonb :settings, default: {}
      t.boolean :client_portal_enabled, default: false
      t.timestamps
    end
    add_index :control_plane_projects, :identifier, unique: true
    add_index :control_plane_projects, :openproject_project_id
  end
end
