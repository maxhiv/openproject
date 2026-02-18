class CreatePermits < ActiveRecord::Migration[8.0]
  def change
    create_table :permits do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :control_plane_project, null: false, foreign_key: true
      t.string :permit_type, null: false
      t.string :jurisdiction
      t.string :permit_number
      t.string :status, default: "pending"
      t.date :submitted_date
      t.date :approved_date
      t.date :expiry_date
      t.text :notes
      t.jsonb :checklist, default: []
      t.timestamps
    end
  end
end
