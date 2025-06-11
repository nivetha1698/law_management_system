class DocumentVersion < ApplicationRecord
    belongs_to :document
    belongs_to :uploaded_by, class_name: "User"
end
