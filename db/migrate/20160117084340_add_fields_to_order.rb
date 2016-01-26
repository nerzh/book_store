class AddFieldsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address_id, :integer
    add_column :orders, :billing_address_id, :integer
    remove_column :shipping_addresses, :order_id
    remove_column :billing_addresses, :order_id
  end
end
