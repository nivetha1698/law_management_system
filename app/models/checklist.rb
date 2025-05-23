class Checklist < ApplicationRecord
  belongs_to :case
  has_many :checklist_items, dependent: :destroy
end
