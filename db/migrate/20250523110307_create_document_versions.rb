class CreateDocumentVersions < ActiveRecord::Migration[7.2]
  def change
    create_table :document_versions do |t|
      t.references "document", foreign_key: true
      t.integer "version_number"
      t.text "file_path"
      t.references "uploaded_by", foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
