class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.integer :cvv
      t.date :exp_date
      t.string :first_name
      t.string :last_name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
