class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :how_to_pay, default: 0
      t.integer :order_status, default: 0
      t.string :postal_code
      t.string :address
      t.string :receiver_name

      t.timestamps
    end
  end
end
