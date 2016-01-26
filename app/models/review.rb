class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :book

  validates :text, presence: true, length: { maximum: 400 }

  ratyrate_rateable "rating"

end
