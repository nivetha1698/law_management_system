class Client < User
  default_scope {
    joins(:roles).where(roles: { name: [ "client" ] })
  }

  #-------------------------------------Associations---------------------------------------------------------
  has_many :court_cases
  has_many :issued_invoices, class_name: "Invoice", foreign_key: "issued_to_id"

  scope :with_open_cases, -> { joins(:court_cases).where(court_cases: { status: "open" }).where(active: true).distinct }
  #-------------------------------------Callbacks---------------------------------------------------------------

  after_create :assign_client_role
  #-----------------------------------------Methods----------------------------------------------------------
  def self.ransackable_attributes(auth_object = nil)
    %w[name email phone]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private

  def assign_client_role
    add_role(:client)
  end
end
