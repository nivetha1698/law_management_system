class CreateDocuments < ActiveRecord::Migration[7.2]
  def change
    create_table :documents do |t|
       t.references "case", foreign_key: true
       t.references "uploaded_by", foreign_key: { to_table: :users }
       t.string "title"
       t.text "file_path", null: false
       
       t.timestamps
    end
  end
end
