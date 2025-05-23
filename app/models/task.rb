class Task < ApplicationRecord
    belongs_to :case
    belongs_to :assignee, class_name: "User", foreign_key: "assigned_to"
end
