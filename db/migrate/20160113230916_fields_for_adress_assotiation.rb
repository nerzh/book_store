class FieldsForAdressAssotiation < ActiveRecord::Migration
  def change
    remove_column :users, :shipping_adderess_id
    remove_column :users, :billing_adderess_id
    add_column :shipping_addresses, :user_id, :integer
    add_column :billing_addresses, :user_id, :integer
  end
end
