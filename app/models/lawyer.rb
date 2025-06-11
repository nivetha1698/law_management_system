class Lawyer < User
  default_scope {
    joins(:roles).where(roles: { name: ['lawyer'] })
  }

  include PgSearch::Model

  pg_search_scope :search_by_name_email_phone,
                  against: [:name, :email, :phone],
                  using:   { tsearch: { prefix: true } }

#-------------------------------------------------Associations-------------------------------------------
  has_many :notes
  has_many :court_cases, through: :case_lawyers
  has_many :case_lawyers, dependent: :destroy
  belongs_to :category
#--------------------------------------------------Methods----------------------------------------------

end