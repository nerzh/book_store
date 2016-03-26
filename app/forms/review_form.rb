require_relative "../../lib/test_lib/slim_form_object"
class ReviewForm
  include ActiveModel::Model
  include SlimFormObject

  #name params
  def self.model_name
    ActiveModel::Name.new(self, nil, "User")
  end

  #validation
  validate :validation_models

  #models for update
  init_models Rating, Review

  def initialize(params: {})
    self.review           = Review.new
    self.rating           = Rating.new

    self.params           = params
  end

end