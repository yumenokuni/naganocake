class RemoveTotalPaymentFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :total_payment, :integer
  end
end
