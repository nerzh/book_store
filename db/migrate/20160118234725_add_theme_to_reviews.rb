class AddThemeToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :theme, :string
  end
end
