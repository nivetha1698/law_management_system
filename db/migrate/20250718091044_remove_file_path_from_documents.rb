class RemoveFilePathFromDocuments < ActiveRecord::Migration[8.0]
  def change
    remove_column :documents, :file_path, :text
  end
end
