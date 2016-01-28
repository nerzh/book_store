class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :authenticate_user!

  def get_order
    Order.where(user_id: current_user.id, aasm_state: 'in_progress').first if current_user
  end
end
