class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :book_id
      t.integer :user_id
      t.integer :points

      t.timestamps null: false
    end
  end
end
