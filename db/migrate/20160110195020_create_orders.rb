class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string   :aasm_state
      t.integer  :total_price, default: 0, null: false
      t.datetime :completed_date
      t.integer  :user_id
      t.integer  :credit_card_id

      t.timestamps null: false
    end
  end
end
