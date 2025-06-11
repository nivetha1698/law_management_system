class Judge < User
  default_scope { joins(:roles).where(roles: { name: [ "judge" ] }) }
end
