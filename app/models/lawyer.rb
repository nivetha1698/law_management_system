class Lawyer < User
  default_scope {
    joins(:roles).where(roles: { name: ['lawyer'] })
  }

#-------------------------------------------------Associations-------------------------------------------
  has_many :cases
  has_many :notes
  belongs_to :category
#--------------------------------------------------Methods----------------------------------------------
  def self.ransackable_attributes(auth_object = nil)
    %w[name email phone category_id created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end