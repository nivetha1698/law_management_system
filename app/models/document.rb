class Document < ApplicationRecord
    belongs_to :case
    belongs_to :uploaded_by, class_name: 'User'
end
