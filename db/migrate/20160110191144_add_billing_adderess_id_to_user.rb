class AddBillingAdderessIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :billing_adderess_id, :integer
  end
end
