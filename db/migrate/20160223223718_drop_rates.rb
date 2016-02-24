class DropRates < ActiveRecord::Migration
  def change
    drop_table :rates
  end
end
