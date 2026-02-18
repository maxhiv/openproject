class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :plan, default: "free"
      t.jsonb :settings, default: {}
      t.boolean :active, default: true
      t.timestamps
    end
    add_index :organizations, :slug, unique: true
  end
end
