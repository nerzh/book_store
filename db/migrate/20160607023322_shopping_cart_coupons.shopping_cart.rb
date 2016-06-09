# This migration comes from shopping_cart (originally 20160606213250)
class ShoppingCartCoupons < ActiveRecord::Migration
  def change
    create_table "shopping_cart_coupons", force: :cascade do |t|
      t.integer  "number"
      t.integer  "discount"
    end
  end
end
