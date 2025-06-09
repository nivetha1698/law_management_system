class Note < ApplicationRecord
   belongs_to :court_case, foreign_key: :case_id
   belongs_to :lawyer
   belongs_to :appointment
end
