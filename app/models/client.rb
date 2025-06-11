class Client < User
  default_scope {
    joins(:roles).where(roles: { name: [ "client" ] })
  }

  #-------------------------------------Associations---------------------------------------------------------
  has_many :court_cases

  #-----------------------------------------Methods----------------------------------------------------------
  def self.ransackable_attributes(auth_object = nil)
    %w[name email phone]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
