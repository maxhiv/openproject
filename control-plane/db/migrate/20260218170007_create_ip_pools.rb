class CreateIpPools < ActiveRecord::Migration[8.0]
  def change
    create_table :ip_pools do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :isp_site, foreign_key: true
      t.string :name, null: false
      t.string :network, null: false
      t.integer :prefix_length, null: false
      t.integer :vlan_id
      t.string :purpose
      t.text :notes
      t.timestamps
    end
    add_index :ip_pools, [:organization_id, :vlan_id]
  end
end
