class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :firebase_uid, null: false
      t.string :email, null: false
      t.string :display_name
      t.string :avatar_url
      t.boolean :superadmin, default: false
      t.datetime :last_login_at
      t.timestamps
    end
    add_index :users, :firebase_uid, unique: true
    add_index :users, :email, unique: true
  end
end
