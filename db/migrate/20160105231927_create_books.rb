class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :descirption
      t.integer :price
      t.integer :amount
      t.integer :author_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
