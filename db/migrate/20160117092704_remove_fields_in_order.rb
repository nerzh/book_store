class RemoveFieldsInOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :shipping_address_id
    remove_column :orders, :billing_address_id
  end
end
