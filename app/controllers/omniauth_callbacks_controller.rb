class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def facebook

    @user = User.find_for_facebook_oauth request.env["omniauth.auth"]

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
      redirect_to root_path
    end

  end

end