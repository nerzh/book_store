class ReviewForm
  include SlimFormObject

  def self.model_name
    ActiveModel::Name.new(self, nil, "Review")
  end

  validate :validation_models

  init_models Rating, Review

  def initialize(params: {})
    self.review           = Review.new
    self.rating           = Rating.new

    self.params           = params
  end

end