class Document < ApplicationRecord
    belongs_to :court_case
    belongs_to :uploaded_by, class_name: 'User'
end
