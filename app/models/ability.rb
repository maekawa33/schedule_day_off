# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case user.role
    when 'admin'
      can :access, :rails_admin
      can :manage, :all
    when 'general'
      can :manage, :all
      cannot :access, :rails_admin
    when 'guest'
      can :manage, :all
      cannot :access, :rails_admin
      cannot :update, User
    else
      can :read, [Schedule, Event, User], published: true
    end
  end
end
