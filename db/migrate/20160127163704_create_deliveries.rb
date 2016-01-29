class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.integer :price, default: 0

      t.timestamps null: false
    end
  end
end
