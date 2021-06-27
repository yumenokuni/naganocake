class AddPaymentToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment, :integer
  end
end
