class Task < ApplicationRecord
    belongs_to :court_case, foreign_key: 'case_id', optional: true
    belongs_to :assignee, class_name: "User", foreign_key: "assigned_to"

    delegate :name, to: :assignee, allow_nil: true
#-----------------------------------------Methods----------------------------------------------------------
  def self.ransackable_attributes(auth_object = nil)
    %w[title assignee_name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[assignee]
  end
   
end
