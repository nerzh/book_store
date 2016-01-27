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
        checkout_form = CheckoutForm.new(current_user, order: get_order, items: items, params: params[:order])
        checkout_form.submit
        checkout_form.save
      else
        checkout_form = CheckoutForm.new(current_user, order: get_order, params: params[:order])
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

  end
end
