class RemoveShippingCostFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :shipping_cost, :integer
  end
end
