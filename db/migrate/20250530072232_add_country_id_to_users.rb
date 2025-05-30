class AddCountryIdToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :country, foreign_key: true
    add_column :users, :court_name, :string
  end
end
