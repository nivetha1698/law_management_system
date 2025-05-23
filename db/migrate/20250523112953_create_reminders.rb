class CreateReminders < ActiveRecord::Migration[7.2]
  def change
    create_table :reminders do |t|
      t.references "user", foreign_key: true
      t.string "content"
      t.datetime "remind_at"
      t.boolean "read", default: false

      t.timestamps
    end
  end
end
