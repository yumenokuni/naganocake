class RemoveReceiverNameFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :receiver_name, :string
  end
end
