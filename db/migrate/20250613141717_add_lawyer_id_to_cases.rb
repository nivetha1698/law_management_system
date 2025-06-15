class AddLawyerIdToCases < ActiveRecord::Migration[8.0]
  def change
    add_column :cases, :lawyer_id, :bigint
  end
end
