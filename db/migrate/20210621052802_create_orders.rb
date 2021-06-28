class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id           #会員ID
      t.string :postal_code            #配送先郵便番号
      t.string :address                #配送先住所
      t.string :name                   #配送先氏名
      t.integer :shipping_id           #配送先ID
      t.integer :shipping_fee          #送料
      t.integer :amount                #請求額
      t.integer :payment, default: 0   #支払い方法
      t.integer :order_status, default: 0 #注文ステータス
      
      t.timestamps
    end
  end
end
