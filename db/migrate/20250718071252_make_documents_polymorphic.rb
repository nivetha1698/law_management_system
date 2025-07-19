class MakeDocumentsPolymorphic < ActiveRecord::Migration[8.0]
  def change
    remove_reference :documents, :case, index: true, foreign_key: true

    add_reference :documents, :documentable, polymorphic: true, index: true
  end
end
