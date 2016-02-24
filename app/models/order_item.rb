class OrderItem < ActiveRecord::Base

  belongs_to :book
  belongs_to :order

  validates :price, :quantity, presence: true

  after_save :update_total_price_in_order

  def update_total_price_in_order
    order_items = OrderItem.where(order_id: self.order)
    total_price = 0
    order_items.each { |order_item| total_price += order_item.price*order_item.quantity }
    self.order.update(total_price: total_price)
  end

end