class RemoveNullColumnFromUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :team_id, true
  end
end
