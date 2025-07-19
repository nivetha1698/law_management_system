class Task < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_keywords,
                  against: :title,
                  associated_against: { court_case: [ :title ] },
                  using: { tsearch: { prefix: true } }

    #--------------------------------Associations---------------------------------------------------

    belongs_to :court_case, foreign_key: "case_id", optional: true
    belongs_to :assignee, class_name: "User", foreign_key: "assigned_to"
    has_many :documents, as: :documentable, dependent: :destroy
    accepts_nested_attributes_for :documents, allow_destroy: true

    delegate :name, to: :assignee, allow_nil: true

    #-------------------------------------Validations---------------------------------------------------

    validates :name, :case_id, :status, :due_date, presence: true

  #-----------------------------------------Methods----------------------------------------------------------
  def self.ransackable_attributes(auth_object = nil)
    %w[title assignee_name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[assignee]
  end
end
