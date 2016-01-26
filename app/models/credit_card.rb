class CreditCard < ActiveRecord::Base

  belongs_to :user
  has_many   :orders

  validates :number, :cvv, :exp_date, :first_name, :last_name, presence: true

end
