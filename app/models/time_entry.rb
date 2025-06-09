class TimeEntry < ApplicationRecord
   belongs_to :user
   belongs_to :court_case
end
