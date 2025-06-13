class Appointment < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_clients_and_cases,
                  associated_against: { client: [ :name ], court_case: [ :title ] },
                  using: { tsearch: { prefix: true } }


  #-----------------------------------------Associations-------------------------------------------
  has_one :note, dependent: :destroy
  belongs_to :client
  belongs_to :court_case, class_name: "CourtCase", foreign_key: "case_id", optional: true
  belongs_to :lawyer, optional: true

  accepts_nested_attributes_for :note, allow_destroy: true
end
