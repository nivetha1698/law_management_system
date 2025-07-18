class Document < ApplicationRecord
    #-------------------------------------------Associations-------------------------------------------
    belongs_to :documentable, polymorphic: true
    belongs_to :uploaded_by, class_name: "User"
    has_many_attached :files

  #-------------------------------------------Validations--------------------------------------------
  validate :acceptable_file_size
  #---------------------------------------------Methods-------------------------------------------------

  def acceptable_file_size
    if files.attached?
    files.each do |file|
      if file.blob.byte_size > 50.megabytes
        errors.add(:files, "#{file.filename} is too big. Maximum size allowed is 50MB.")
      end
    end
    end
  end
end
