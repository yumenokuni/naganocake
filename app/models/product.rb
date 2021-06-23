class Product < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_items
end
