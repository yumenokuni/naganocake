class AddGenreIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :genre_id, :integer
  end
end