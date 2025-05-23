class Case < ApplicationRecord
   has_many :tasks, dependent: :destroy
   has_many :checklists, dependent: :destroy
   has_many :time_entries
   has_many :invoices
   belongs_to :client, class_name: 'User'
   belongs_to :category
   has_and_belongs_to_many :tags
end
