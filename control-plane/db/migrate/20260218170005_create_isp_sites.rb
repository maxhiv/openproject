class CreateIspSites < ActiveRecord::Migration[8.0]
  def change
    create_table :isp_sites do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :control_plane_project, foreign_key: true
      t.string :name, null: false
      t.text :address
      t.decimal :latitude, precision: 10, scale: 7
      t.decimal :longitude, precision: 10, scale: 7
      t.text :notes
      t.string :status, default: "active"
      t.jsonb :metadata, default: {}
      t.timestamps
    end
    add_index :isp_sites, [:organization_id, :name]
  end
end
