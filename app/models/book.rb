class Book < ActiveRecord::Base

  has_and_belongs_to_many :authors
  has_many                :ratings, class_name: 'Rate', foreign_key: 'rateable_id', dependent: :delete_all
  has_many                :reviews, dependent: :delete_all
  has_many                :orders, through:   :order_items
  has_many                :order_items
  belongs_to              :category

  validates :title, :price, :amount, presence: true

  mount_uploader :cover, CoverUploader

  paginates_per 6

  ratyrate_rater

  def show_price
    return 0.0 if self.price.nil?
    (self.price.to_d/1000).round 2
  end

end