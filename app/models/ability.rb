# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    user_roles = user.roles.pluck(:name)

    if user_roles.include?("lawyer")
      can :read, :dashboard
      
      can :read, CourtCase, lawyers: { id: user.id }
      cannot :destroy, CourtCase

      can :manage, Task, assigned_to: user.id
      cannot :destroy, Task

      can :manage, Appointment, lawyer_id: user.id

      can :manage, Invoice, court_case: { lawyer_id: user.id }
      cannot :destroy, Invoice

      can [:read, :update], User, user_id: user.id

      
      
      cannot :manage, User
      cannot :manage, Judge
      cannot :manage, Role
      cannot :manage, Category
    end

    if user_roles.include?("admin")
      can :manage, :all
    end

    if user_roles.include?("client")
      can :read, CourtCase, client_id: user.id
      can :read, Appointment, client_id: user.id
      can :read, Invoice, issued_to_id: user.id
      cannot :destroy, Invoice
    end

    if user_roles.include?("judge")
      can :read, Case
      can :manage, Hearings, case: { judge_id: user.id }
      can :manage, Judgment, judge_id: user.id # Issue judgments for cases they oversee
      can :read, Document, case: { status: "closed" } # View documents of closed cases
    end
  end
end
