# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'login'
      can :manage, :all
    elsif user.role == 'guest'
      can :manage, :all
      cannot :update, User
    else
      can :read, [Schedule, Event, User], published: true
    end

  end
end
