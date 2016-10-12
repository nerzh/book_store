class ReviewForm
  include SlimFormObject
  set_model_name 'Review'

  validate :validation_models

  init_models Rating, Review

  def initialize(params: {})
    self.review           = Review.new
    self.rating           = Rating.new

    self.params           = params_review(params)
  end

  private

  def params_review(params)
    return {} if params.empty?
    params.require(:review).permit(:rating_points, :rating_book_id, :rating_user_id, :review_theme,
                                   :review_text,   :review_user_id, :review_book_id)
  end
end