# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user.roles.each do |role|
      send("#{role.name}_abilities", user)
    end
  end

  def admin_abilities(user)
    can :read, :all
    can :manage, :Jet
    can :manage, :Post
    can :manage, :Comment
  end

  def moderator_abilities(user)
    can :read, :all
    can :manage, :Jet
    can [:read, :destroy], :Post
    can [:read, :destroy], :Comment
  end

  def member_abilities(user)
    can :read, :all
    can :manage, :Post
    can :manage, :Comment
    can :manage, User, { id: user.id }
  end

  def visitor_abilities(user)
    can :read, :all
  end

  def to_list
    rules.map do |rule|
      object = { actions: rule.actions, subject: rule.subjects.map{ |s| s.is_a?(Symbol) ? s : s.name } }
      object[:conditions] = rule.conditions unless rule.conditions.blank?
      object[:inverted] = true unless rule.base_behavior
      object
    end
  end
end
