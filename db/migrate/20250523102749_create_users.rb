class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :password_digest
      t.references :team, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
