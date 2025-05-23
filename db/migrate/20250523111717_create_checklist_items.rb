class CreateChecklistItems < ActiveRecord::Migration[7.2]
  def change
    create_table :checklist_items do |t|
      t.references :checklist, foreign_key: true
      t.string :content
      t.boolean :completed

      t.timestamps
    end
  end
end
