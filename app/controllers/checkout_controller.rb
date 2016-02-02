require_relative '../forms/form_for_checkout'
class CheckoutController < ApplicationController
  before_action :authenticate_user!

  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete, :delete

  before_action -> { redirect_to shop_index_path         if session[:cart].nil? or session[:cart].empty? and !get_order and
                                                            [:address, :delivery, :payment, :confirm].include?(step) }
  before_action -> { redirect_to checkout_path(:address) if session[:cart].nil? or session[:cart].empty? and
                                                            get_order and step == :complete }

  def show
    if order = get_order
      @checkout_form = CheckoutForm.new(current_user, order: order)
    else
      @checkout_form = CheckoutForm.new(current_user, order: current_user.orders.last) and render_wizard and return if step == :complete
      books = Book.where(id: session[:cart].keys)
      items = []
      books.each do |book|
        items << OrderItem.new(book_id: book.id, price: book.price, quantity: session[:cart][book.id.to_s])
      end
      order = Order.create(user_id: current_user.id)
      order.order_items << items
      @checkout_form = CheckoutForm.new(current_user, order: order)
    end

    render_wizard
  end

  def update
    case step
      when :address
        checkout_form = CheckoutForm.new(current_user, order: get_order, params: parameters)
        checkout_form.submit
        jump_to(step) and render_wizard and return unless checkout_form.save
        session[:cart].clear
      when :confirm
        get_order.completed!
      else
        jump_to(:address) and render_wizard and return unless session[:cart].empty?
        checkout_form = CheckoutForm.new(current_user, order: get_order, params: parameters)
        checkout_form.submit
        jump_to(step) unless checkout_form.save
    end
    render_wizard current_user
  end

  def destroy
    get_order&.delete and redirect_to root_path
  end

  private

  def parameters
    case step
      when :address
        params.require(:order).permit(:order_billing_address_first_name, :order_billing_address_last_name,
                                      :order_billing_address_street,     :order_billing_address_city,
                                      :order_billing_address_country_id, :order_billing_address_zip,
                                      :order_billing_address_phone,      :order_shipping_address_first_name,
                                      :order_shipping_address_last_name, :order_shipping_address_street,
                                      :order_shipping_address_city,      :order_shipping_address_country_id,
                                      :order_shipping_address_zip,       :order_shipping_address_phone)
      when :delivery
        params.require(:order).permit(:order_delivery_id)
      when :payment
        params.require(:order).permit(:credit_card_number,    :credit_card_cvv,        :credit_card_exp_year,
                                      :credit_card_exp_month, :credit_card_first_name, :credit_card_last_name)
    end
  end
end
