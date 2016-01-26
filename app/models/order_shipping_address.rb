class OrderShippingAddress < ActiveRecord::Base
  belongs_to :order
  belongs_to :country

  validates :first_name, :last_name, :street, :city, :zip, :phone, presence: true

  # after_create :default_address

  def default_address
    return unless current_user
    OrderShippingAddress.update(first_name: current_user.shipping_address.first_name,
                                last_name:  current_user.shipping_address.last_name,
                                street:     current_user.shipping_address.street,
                                city:       current_user.shipping_address.city,
                                zip:        current_user.shipping_address.zip,
                                phone:      current_user.shipping_address.phone
                                )
  end
end
