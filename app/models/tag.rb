class Tag < ApplicationRecord
   has_and_belongs_to_many :court_cases
end
