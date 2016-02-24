class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews,          dependent: :delete_all
  has_many :orders,           dependent: :delete_all
  has_many :ratings,          dependent: :delete_all
  has_one  :shipping_address, dependent: :delete
  has_one  :billing_address,  dependent: :delete
  has_one  :credit_card,      dependent: :delete

end