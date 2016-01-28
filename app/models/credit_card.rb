class CreditCard < ActiveRecord::Base

  belongs_to :user
  has_many   :orders

  validates :number, :cvv, :exp_date, :first_name, :last_name, presence: true
  validates :cvv,    format: { with: /\A\d{3}\z/ }
  validates :number, format: { with: /\A\d{16}\z/ }

end
