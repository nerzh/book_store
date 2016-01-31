module ApplicationHelper
  def show_price(price)
    return 0.0 if price.nil?
    (price.to_d/1000).round 2
  end
end
