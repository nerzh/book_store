class Rating < ActiveRecord::Base

  belongs_to :user
  belongs_to :book
  belongs_to :review

  validates  :points, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }

end
