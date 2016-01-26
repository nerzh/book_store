class AddShippingAdderessIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :shipping_adderess_id, :integer
  end
end
