# This migration comes from shopping_cart (originally 20160609101446)
class ShoppingCartDeliveries < ActiveRecord::Migration
  def change
    create_table "shopping_cart_deliveries", force: :cascade do |t|
      t.string   "name"
      t.integer  "price",      default: 0
    end
  end
end
