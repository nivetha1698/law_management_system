class Document < ApplicationRecord
  #-------------------------------------------Associations-------------------------------------------
    belongs_to :documentable, polymorphic: true
    belongs_to :uploaded_by, class_name: "User"

  #-------------------------------------------Validations--------------------------------------------

  validates :file_path, presence: true
end
