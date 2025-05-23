class CreateCases < ActiveRecord::Migration[7.2]
  def change
    create_table :cases do |t|
      t.string "title", null: false
      t.text "description"
      t.string "status", default: "open"
      t.string "priority"
      t.string "workflow_status", default: "intake"
      t.references "client", foreign_key: { to_table: :users }
      t.references "category", foreign_key: true
      
      t.timestamps
    end
  end
end
