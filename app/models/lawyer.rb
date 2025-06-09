class Lawyer < User
  default_scope {
    joins(:roles).where(roles: { name: ['lawyer'] })
  }

#-------------------------------------------------Associations-------------------------------------------
  has_many :notes
  has_many :court_cases, through: :case_lawyers
  has_many :case_lawyers, dependent: :destroy
  belongs_to :category
#--------------------------------------------------Methods----------------------------------------------
  def self.ransackable_attributes(auth_object = nil)
    %w[name email phone category_id created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end