class ReviewController < ApplicationController
  authorize_resource

  def new
    @book = Book.find(params[:book])
    @user = current_user
  end

  def create
    review = ReviewForm.new(params: params_review)
    review.submit
    review.save ? (render json: {status: 200}) : (render json: review.errors, status: :unprocessable_entity)
  end

  private

  def define_review
    @review = Review.find(params[:id])
  end

  def params_review
    params.require(:review).permit(:rating_points, :rating_book_id, :rating_user_id, :review_theme,
                                   :review_text, :review_user_id, :review_book_id)
  end
end
