module ApplicationHelper
  def show_price(price)
    (price.to_d/1000).round 2
  end
end
