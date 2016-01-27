class AddDeliveryIdToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :delivery_id, :integer
  end
end
