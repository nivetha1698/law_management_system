class AddColumnToCases < ActiveRecord::Migration[8.0]
  def change
    add_column :cases, :case_number, :string
    add_column :cases, :first_hearing_date, :date
    add_column :cases, :next_hearing_date, :date
    add_column :cases, :court_no, :string
    add_reference :cases, :judge, foreign_key: { to_table: :users }
  end
end
