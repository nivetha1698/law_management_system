class Note < ApplicationRecord
    belongs_to :case
    belongs_to :lawyer, class_name: 'User'
end
