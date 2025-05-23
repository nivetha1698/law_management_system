class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.references "case", foreign_key: true
      t.string "title"
      t.text "description"
      t.date "due_date"
      t.string "status", default: "pending"
      t.bigint "assigned_to"

      t.timestamps
    end
     add_index :tasks, :assigned_to
     add_foreign_key :tasks, :users, column: :assigned_to
  end
end
