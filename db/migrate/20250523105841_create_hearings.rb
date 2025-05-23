class CreateHearings < ActiveRecord::Migration[7.2]
  def change
    create_table :hearings do |t|
      t.references "case", foreign_key: true
      t.datetime "date", null: false
      t.string "location"
      t.text "notes"

      t.timestamps
    end
  end
end
