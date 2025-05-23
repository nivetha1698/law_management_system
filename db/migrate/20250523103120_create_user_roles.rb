class CreateUserRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :user_roles do |t|
      t.references :user, foreign_key: true
      t.references :role, foreign_key: true
      
      t.timestamps
    end
  end
end
