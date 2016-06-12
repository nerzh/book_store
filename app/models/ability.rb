class Ability
  include CanCan::Ability

  def initialize(user)
    if user&.admin?
      can :manage,   :all
      can :access,   :rails_admin
      can :dashboard
    elsif user&.user?
      can :read,     Book
      can :read,     Category
      can :read,     :main
      can :create,   Review,    {user: user}
    else
      can :read,     Book
      can :read,     Category
      can :read,     :main
    end
  end

end