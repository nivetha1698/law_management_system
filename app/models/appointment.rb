class Appointment < ApplicationRecord
  has_one :note, dependent: :destroy
  belongs_to :client
  belongs_to :court_case, class_name: 'CourtCase', foreign_key: 'case_id', optional: true
  belongs_to :lawyer, optional: true

  accepts_nested_attributes_for :note, allow_destroy: true
end
