class Order < ApplicationRecord
    belongs_to :customer                             #会員
    has_many :ordered_products, dependent: :destroy  #注文商品
    validates :postal_code, presence: true           #郵便番号
    validates :address, presence: true               #住所
    validates :receiver_name, presence: true         #受取人
end