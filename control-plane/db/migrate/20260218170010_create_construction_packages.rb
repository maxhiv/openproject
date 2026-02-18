class CreateConstructionPackages < ActiveRecord::Migration[8.0]
  def change
    create_table :construction_packages do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :control_plane_project, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :status, default: "planning"
      t.string :wbs_code
      t.date :planned_start
      t.date :planned_end
      t.date :actual_start
      t.date :actual_end
      t.decimal :progress_pct, precision: 5, scale: 2, default: 0
      t.jsonb :metadata, default: {}
      t.timestamps
    end
  end
end
