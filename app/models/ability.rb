# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :access, :rails_admin
      can :manage, :all
    elsif user.role == 'general'
      can :manage, :all
      cannot :access, :rails_admin
    elsif user.role == 'guest'
      can :manage, :all
      cannot :access, :rails_admin
      cannot :update, User
    else
      can :read, [Schedule, Event, User], published: true
    end
  end
end
