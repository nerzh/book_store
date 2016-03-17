class OrderController < ApplicationController
  before_action :define_order, only: [:show]
  authorize_resource

  include CartItems

##############   I N D E X   and   S H O W

## GET
  def index
    @orders      = current_user&.orders
    @order       = @orders.find_by(aasm_state: 'in_progress')
    @order_items = get_items_hash(order: @order) or get_items_hash(session: session)
    @shipping    = @orders.where(aasm_state: 'shipping')
    @completed   = @orders.where(aasm_state: 'completed')
  end

## GET
  def show

  end

##############   C R E A T E

## GET
  def new
    @book = Book.find(params[:book])
    @user = current_user
  end

## POST
  def create
    review = ReviewForm.new(params: params_review)
    review.submit
    review.save ? (render json: {status: 200}) : (render json: review.errors, status: :unprocessable_entity)
  end

##############   U P D A T E

## GET
  def edit

  end

## PATCH
  def update

  end

##############   D E L E T E

## DELETE
  def delete

  end

## DELETE
  def destroy

  end

##############   M Y   M E T H O D S

  private

  def define_order

    @order = Order.find(params[:id])

  end

  def params_order
    params.require(:order).permit(:rating_points, :rating_book_id, :rating_user_id, :review_theme,
                                   :review_text, :review_user_id, :review_book_id)
  end
end
