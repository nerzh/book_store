class ReviewForm
  include SlimFormObject
  set_model_name 'Review'

  validate :validation_models

  init_models Rating, Review

  def initialize(params: {})
    self.review           = Review.new
    self.rating           = Rating.new

    self.params           = params
  end

end