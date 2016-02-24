class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :book
  has_one    :rating, dependent: :delete

  validates :text,  presence: true, length: { maximum: 400 }
  validates :theme, presence: true, length: { maximum: 150 }

end
