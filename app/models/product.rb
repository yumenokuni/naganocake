class Product < ApplicationRecord

  attachment :image

  belongs_to :genre
  has_many :cart_items

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

end
