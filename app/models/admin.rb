class Admin < User
  default_scope { joins(:roles).where(roles: { name: ADMIN_ROLES }) }
end
