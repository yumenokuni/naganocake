class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.integer :customer_id
      t.string :name
      t.string :postal_code
      t.string :address
      t.timestamp :created_at
      t.timestamp :update_at

      t.timestamps
    end
  end
end
