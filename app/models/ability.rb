# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user.roles.each do |role|
      send("#{role.name}_abilities", user)
    end
  end

  def admin_abilities(user)
    can :manage, :all
  end

  def moderator_abilities(user)
    can :read, :all
    can :manage, :jet, { mod_id: user.id }
  end

  def member_abilities(user)
    can :read, :all
    can :manage, :post, { author_id: user.id }
    can :manage, :comment, { author_id: user.id }
    can [:read, :update], User, { id: user.id }
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
