class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes do |t|
      t.references "case", foreign_key: true
      t.references "lawyer", foreign_key: { to_table: :users }
      t.text "content", null: false

      t.timestamps
    end
  end
end
