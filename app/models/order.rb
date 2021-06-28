class Order < ApplicationRecord
    
    belongs_to :customer                             #会員
    has_many :ordered_products, dependent: :destroy  #注文商品
    validates :postal_code, presence: true           #郵便番号
    validates :address, presence: true               #住所
    validates :name, presence: true         #受取人
    
    enum order_status: {
    waiting: 0,
    paid_up: 1,
    preparing: 2,
    shipped: 3
}
    
    
end