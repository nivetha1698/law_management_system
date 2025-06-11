class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.references "user", foreign_key: true
      t.text "message", null: false
      t.boolean "read", default: false

      t.timestamps
    end
  end
end
