class Role < ApplicationRecord
  #---------------------------------Associations--------------------------------------------------------------
  has_and_belongs_to_many :users, join_table: :users_roles
  belongs_to :resource, polymorphic: true, optional: true

  #-------------------------------------validations----------------------------------------------------
  validates :name, presence: true
end
