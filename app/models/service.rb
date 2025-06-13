class Service < ApplicationRecord
   include PgSearch::Model

  pg_search_scope :search_by_service_name,
                  against: :name,
                  using: { tsearch: { prefix: true } }
  
  #---------------------------Associations------------------------------------------------------
  has_many :invoice_items
end
