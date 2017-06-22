ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.extend(ShoppingCart::Settings::Product)
  ActiveRecord::Base.extend(ShoppingCart::Settings::User)
  ShoppingCart.product_model = Book
  ShoppingCart.user_model    = User
end