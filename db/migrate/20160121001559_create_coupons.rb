class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :number
      t.integer :discount

      t.timestamps null: false
    end
  end
end
