class CreateNetworkAssets < ActiveRecord::Migration[8.0]
  def change
    create_table :network_assets do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :isp_site, foreign_key: true
      t.string :asset_type, null: false
      t.string :vendor
      t.string :model
      t.string :serial_number
      t.string :ip_address
      t.string :mac_address
      t.string :location
      t.string :status, default: "active"
      t.jsonb :metadata, default: {}
      t.timestamps
    end
    add_index :network_assets, :asset_type
    add_index :network_assets, :serial_number
    add_index :network_assets, [:organization_id, :asset_type]
  end
end
