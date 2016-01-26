class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.integer :country_id
      t.string :zip
      t.string :phone

      t.timestamps null: false
    end
  end
end
