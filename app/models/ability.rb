class Ability

  include CanCan::Ability

  def initialize(user, order)

    if user&.admin?
      can :manage, :all
    elsif user&.user?
      can :read,   Book
      can :read,   Category
      can :manage, :checkout if order&.user == user
      can :read,   :main
      can :crud,   Order
      can :manage, Order
      can :create, Review,    {user: user}
      # can :manage, :settings, {user: user}
      # can :manage, :settings
    else
      can :read,   Book
      can :read,   Category
      can :read,   :main
    end





    # case user.current_role
    #
    #   when 'admin'
    #     can :manage, :all
    #
    #   when 'user'
    #     can :manage, List, { user: user }
    #     can :manage, Task, list: { user: user }
    #     can :manage, Comment, task: { list: { user: user } }
    #     can :manage, Upload, comment: {task: { list: { user: user } }}
    #   else
    #     cannot :manage, :all
    #
    #   # ... other roles and abilities ...
    #
    # end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
