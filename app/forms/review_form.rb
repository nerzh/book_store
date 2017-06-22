class ReviewForm < SlimFormObject::Base
  
  set_model_name 'Review'
  validate :validation_models
  init_models Rating, Review

  def initialize(params: {})
    super(params: params_review(params))
  end

  private

  def params_review(params)
    return {} if params.empty?
    params.require(:review).permit(rating: [:points, :book_id, :user_id], review: [:theme, :text, :user_id, :book_id])
  end
end