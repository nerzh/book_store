class AddColumnsInAddress < ActiveRecord::Migration
  def change
    add_column :billing_addresses, :order_id, :integer
    add_column :shipping_addresses, :order_id, :integer
  end
end
