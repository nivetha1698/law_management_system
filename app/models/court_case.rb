class CourtCase < ApplicationRecord
   self.table_name = "cases"

  include PgSearch::Model

  pg_search_scope :search_by_keywords,
                  against: [ :case_number, :title, :court_no ],
                  using:   { tsearch: { prefix: true } }


   #--------------------------------------------Associations------------------------------------------------------------
   has_many :tasks, dependent: :destroy
   has_many :checklists, dependent: :destroy
   has_many :time_entries
   has_many :invoices
   has_many :case_lawyers, foreign_key: :case_id, dependent: :destroy
   has_many :lawyers, through: :case_lawyers
   belongs_to :client
   belongs_to :category
   belongs_to :judge, class_name: "User", optional: true
   has_and_belongs_to_many :tags
   accepts_nested_attributes_for :case_lawyers, allow_destroy: true
   belongs_to :lawyer, class_name: "User", foreign_key: "lawyer_id", optional: true

  #-----------------------------------------Methods----------------------------------------------------------
end
