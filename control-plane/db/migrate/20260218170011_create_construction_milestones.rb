class CreateConstructionMilestones < ActiveRecord::Migration[8.0]
  def change
    create_table :construction_milestones do |t|
      t.references :construction_package, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.date :due_date
      t.date :completed_date
      t.string :status, default: "pending"
      t.boolean :client_visible, default: false
      t.boolean :requires_client_approval, default: false
      t.datetime :client_approved_at
      t.references :approved_by, foreign_key: { to_table: :users }
      t.integer :sort_order, default: 0
      t.integer :openproject_work_package_id
      t.jsonb :dependencies, default: []
      t.timestamps
    end
    add_index :construction_milestones, :openproject_work_package_id
  end
end
