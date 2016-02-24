class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :points
      t.integer :user_id
      t.integer :book_id
      t.integer :review_id

      t.timestamps null: false
    end
  end
end
