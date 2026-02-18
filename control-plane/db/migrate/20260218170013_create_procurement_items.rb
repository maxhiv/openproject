class CreateProcurementItems < ActiveRecord::Migration[8.0]
  def change
    create_table :procurement_items do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :control_plane_project, foreign_key: true
      t.references :construction_package, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :vendor
      t.string :part_number
      t.integer :quantity, default: 1
      t.decimal :unit_cost, precision: 10, scale: 2
      t.string :status, default: "pending"
      t.integer :lead_time_days
      t.date :order_date
      t.date :expected_delivery_date
      t.date :actual_delivery_date
      t.text :notes
      t.timestamps
    end
  end
end
