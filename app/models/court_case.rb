class CourtCase < ApplicationRecord
   self.table_name = "cases"
  
 #--------------------------------------------Associations------------------------------------------------------------  
   has_many :tasks, dependent: :destroy
   has_many :checklists, dependent: :destroy
   has_many :time_entries
   has_many :invoices
   has_many :case_lawyers, foreign_key: :case_id, dependent: :destroy
   has_many :lawyers, through: :case_lawyers
   belongs_to :client
   belongs_to :category
   belongs_to :judge, class_name: 'User', optional: true
   has_and_belongs_to_many :tags
   accepts_nested_attributes_for :case_lawyers, allow_destroy: true

#-----------------------------------------Methods----------------------------------------------------------
  def self.ransackable_attributes(auth_object = nil)
    %w[case_number title court_no]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
   
end
