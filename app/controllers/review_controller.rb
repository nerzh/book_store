class ReviewController < ApplicationController
  authorize_resource

  def new
    @book = Book.find(params[:book])
    @user = current_user
  end

  def create
    review = ReviewForm.new(params: params)
    review.apply_parameters
    review.save ? (render json: {status: 200}) : (render json: review.errors, status: :unprocessable_entity)
  end
end
