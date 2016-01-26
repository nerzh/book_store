class OrderBillingAddress < ActiveRecord::Base
  belongs_to :order
  belongs_to :country

  validates :first_name, :last_name, :street, :city, :zip, :phone, presence: true

  # after_create :default_address

  def default_address
    return unless current_user
    OrderBillingAddress.update(first_name: current_user.billing_address.first_name,
                               last_name:  current_user.billing_address.last_name,
                               street:     current_user.billing_address.street,
                               city:       current_user.billing_address.city,
                               zip:        current_user.billing_address.zip,
                               phone:      current_user.billing_address.phone
                              )
  end
end
