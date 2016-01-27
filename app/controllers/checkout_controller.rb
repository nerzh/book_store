require_relative '../forms/form_for_checkout'
class CheckoutController < ApplicationController

  before_action :authenticate_user!
  before_action -> { redirect_to shop_index_path if session[:cart].nil? or session[:cart].empty? }

  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete


  def show
    if order = get_order
      @checkout_form = CheckoutForm.new(current_user, order: order)
    else
      @checkout_form = CheckoutForm.new(current_user)
    end

    render_wizard
  end

  def update
    case step
      when :address
        books = Book.where(id: session[:cart].keys)
        items = []
        books.each do |book|
          items << OrderItem.new(book_id: book.id, price: book.price, quantity: session[:cart][book.id.to_s])
        end
        checkout_form = CheckoutForm.new(current_user, order: get_order, items: items, params: parameters)
        checkout_form.submit
        checkout_form.save
      else
        checkout_form = CheckoutForm.new(current_user, order: get_order, params: parameters)
        checkout_form.submit
        checkout_form.save
    end
    render_wizard current_user
  end

  private

  def redirect_to_finish_wizard
    redirect_to root_path, notice: "Thank you for signing up."
  end

  def parameters
    case step
      when :address
        params.require(:order).permit(:order_billing_address_first_name, :order_billing_address_last_name,
                                      :order_billing_address_street, :order_billing_address_city,
                                      :order_billing_address_country_id, :order_billing_address_zip,
                                      :order_billing_address_phone)
      when :delivery
        params.require(:order).permit(:order_delivery_id)
      when :payment
        params.require(:order).permit(:credit_card_number, :credit_card_cvv, :credit_card_exp_date,
                                      :credit_card_first_name, :credit_card_last_name)
    end
  end
end
