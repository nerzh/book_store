include FactoryGirl::Syntax::Methods

namespace :prod do

  task create: :environment do
    create_list(:category, 10) if Category.all.empty?
    create_list(:book, 20, :uniq, :authors) if Book.all.empty?
    create_list(:user, 6, :rand_with_full)
    create_list(:review, 20, :with_rand)
    # create_list(:rating, 20, :with_rand)
    Order.find_each do |order|
      order.order_shipping_address = OrderShippingAddress.create(first_name: order.user.shipping_address.first_name,
                                                                 last_name:  order.user.shipping_address.last_name,
                                                                 street:     order.user.shipping_address.street,
                                                                 city:       order.user.shipping_address.city,
                                                                 zip:        order.user.shipping_address.zip,
                                                                 phone:      order.user.shipping_address.phone,
                                                                 country_id: order.user.shipping_address.country_id
                                                                 )

      order.order_billing_address = OrderBillingAddress.create(first_name: order.user.billing_address.first_name,
                                                               last_name:  order.user.billing_address.last_name,
                                                               street:     order.user.billing_address.street,
                                                               city:       order.user.billing_address.city,
                                                               zip:        order.user.billing_address.zip,
                                                               phone:      order.user.billing_address.phone,
                                                               country_id: order.user.shipping_address.country_id
                                                               )
      order.credit_card.update(user_id: order.user.id)
    end
    BillingAddress.find_each do |address|
      address.user.update(first_name: address.first_name, last_name: address.last_name)
    end
  end

end