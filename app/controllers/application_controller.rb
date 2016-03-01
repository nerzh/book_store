class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_action :set_csrf_cookie_for_ng

  respond_to :html, :json

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def get_order
    Order.where(user_id: current_user.id, aasm_state: 'in_progress').first if current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: t('access_denied')
  end

  protected

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user, get_order)
  end

end
