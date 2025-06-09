class AddCategoryIdToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :category_id, :bigint
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :zipcode, :string
    add_column :users, :gender, :string
    add_column :users, :state, :string
  end
end
