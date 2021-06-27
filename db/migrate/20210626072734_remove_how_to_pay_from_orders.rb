class RemoveHowToPayFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :how_to_pay, :integer
  end
end
