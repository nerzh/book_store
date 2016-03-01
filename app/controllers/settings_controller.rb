require_relative '../forms/form_for_settings'
class SettingsController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource :class => "SettingsForm"

  ##############   I N D E X   and   S H O W

  ## GET
  def index

  end

  ## GET
  def show
    @settings_form = SettingsForm.new(current_user)
    # authorize! :settings, @settings
    @user = current_user
    # @settings = SettingsForm.new(@user)
  end

  ##############   C R E A T E

  ## GET
  def new

  end

  ## POST
  def create

  end

  ##############   U P D A T E

  ## GET
  def edit

  end

  ## PATCH
  def update
    @settings = SettingsForm.new(current_user, params: parameters)
    @settings.submit
    redirect_to root_path and return if @settings.save
    redirect_to settings_path
  end

  ##############   D E L E T E

  ## DELETE
  def delete

  end

  ## DELETE
  def destroy

  end

  ##############   M Y   M E T H O D S

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(parameters_password)
      sign_in @user, bypass: true
      redirect_to root_path
    else
      redirect_to settings_path
    end
  end

  private

  def parameters
    params.require(:user).permit(:billing_address_first_name, :billing_address_last_name, :billing_address_street,
                                 :billing_address_city, :billing_address_country_id, :billing_address_zip,
                                 :billing_address_phone, :shipping_address_first_name, :shipping_address_last_name,
                                 :shipping_address_street, :shipping_address_city, :shipping_address_country_id,
                                 :shipping_address_zip, :shipping_address_phone, :credit_card_number, :credit_card_cvv,
                                 :credit_card_exp_year, :credit_card_exp_month, :credit_card_first_name,
                                 :credit_card_last_name, :user_email)
  end

  def parameters_password
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
