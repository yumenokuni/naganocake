class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image_id
      t.text :introduction
      t.text :price
      t.boolean :is_active
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end
end
