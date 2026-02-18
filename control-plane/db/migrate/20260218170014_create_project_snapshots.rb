class CreateProjectSnapshots < ActiveRecord::Migration[8.0]
  def change
    create_table :project_snapshots do |t|
      t.references :control_plane_project, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.string :label
      t.jsonb :snapshot_data, default: {}
      t.timestamps
    end
  end
end
