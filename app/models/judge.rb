class Judge < User
  default_scope { joins(:roles).where(roles: { name: [ "judge" ] }) }

  include PgSearch::Model

  pg_search_scope :search_by_keywords,
                  against: [ :name, :court_name ],
                  using: { tsearch: { prefix: true } }

  #------------------------------------Validations------------------------------------------------------

  validates :name, :court_name, presence: true
end
