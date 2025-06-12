# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    user_roles = user.roles.pluck(:name)

    if user_roles.include?('lawyer')
      can :read, Case, lawyer_id: user.id
      can :read, Task, lawyer_id: user.id
      can :manage, Appointment, lawyer_id: user.id
      can :manage, Document, case: { lawyer_id: user.id } 
      can :manage, DocumentVersions, document: { case: { lawyer_id: user.id } } 
      can :create, Notes, lawyer_id: user.id
      cannot :destroy, Case
    end

    if user_roles.include?('admin')
      can :manage, :all 
    end

    if user_roles.include?('client')
      can :read, Case, client_id: user.id  
      can :read, Document, case: { client_id: user.id } 
      can :read, DocumentVersions, document: { case: { lawyer_id: user.id } } 
      can :read, Appointment, lawyer_id: user.id 
    end

    if user_roles.include?('judge')
      can :read, Case 
      can :manage, Hearings, case: { judge_id: user.id } 
      can :manage, Judgment, judge_id: user.id # Issue judgments for cases they oversee
      can :read, Document, case: { status: 'closed' } # View documents of closed cases
    end
  end
end
