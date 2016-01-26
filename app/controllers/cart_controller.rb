class CartController < ApplicationController

  before_action -> { session[:cart] ||= Hash.new; session[:coupon] ||= Hash.new }

  ##############   I N D E X   and   S H O W

  ## GET
  # def index
  #
  # end

  ## GET
  def show
    @total_price = 0
    @cart = {}
    books = Book.where(id: session[:cart].keys)
    books.each do |book|
      @cart[book.id]               = {}
      @cart[book.id][:title]       = book.title
      @cart[book.id][:description] = book.description
      @cart[book.id][:price]       = book.show_price

      unless session[:coupon]['discount'].nil?
        @cart[book.id][:price] = (@cart[book.id][:price] - @cart[book.id][:price]*session[:coupon]['discount']/100).round 2
      end

      @cart[book.id][:amount] = session[:cart][book.id.to_s].to_i
      @cart[book.id][:total]  = book.show_price*session[:cart][book.id.to_s].to_i
      @cart[book.id][:image]  = book.cover.small
    end
  end

  ##############   C R E A T E

  ## GET
  def add
    unless session[:cart][params[:id]].nil?
      session[:cart][params[:id]] = session[:cart][params[:id]].to_i + params[:quantity].to_i
      redirect_to cart_path and return
    end
    session[:cart][params[:id]] = params[:quantity].to_i

    redirect_to cart_path
  end

  ## POST
  # def create
  #
  # end

  ##############   U P D A T E

  ## GET
  def edit

  end

  ## PATCH
  def update
    if params[:coupon] =~ /^\d+$/
      coupon = Coupon.where(number: params[:coupon]).first
      session[:coupon]['number']   = coupon&.number
      session[:coupon]['discount'] = coupon&.discount
    else
      session[:coupon]['number']   = nil
      session[:coupon]['discount'] = nil
    end
    params[:cart].keys.each do |book_id|
      session[:cart].delete(book_id) and next if params[:cart][book_id] == ''
      session[:cart][book_id] = params[:cart][book_id]
    end

    redirect_to cart_path
  end

  ##############   D E L E T E

  ## DELETE
  # def delete
  #
  # end

  ## DELETE
  def destroy
    if params[:stat] == "0"
      session[:cart].delete(params[:id]) if session[:cart].key? params[:id]
    elsif params[:stat] == "1"
      session[:cart].clear
    end

    redirect_to cart_path
  end

  ##############   M Y   M E T H O D S

  private

end