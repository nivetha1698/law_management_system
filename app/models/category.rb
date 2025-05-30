class Category < ApplicationRecord
   has_many :lawyers, class_name: 'Lawyer', foreign_key: 'category_id'
   has_many :cases
end
