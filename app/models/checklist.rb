class Checklist < ApplicationRecord
  belongs_to :court_case
  has_many :checklist_items, dependent: :destroy
end
