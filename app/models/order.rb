class Order < ApplicationRecord
    
    belongs_to :customer                             #会員
    has_many :ordered_products, dependent: :destroy  #注文商品
    validates :postal_code, presence: true           #郵便番号
    validates :address, presence: true               #住所
    validates :name, presence: true         #受取人
    
    enum order_status: {
    "入金待ち": 0,
    "入金確認": 1,
    "製作中": 2,
    "発送準備中": 3,
    "発送済み": 4
}
     enum payment: {
         "クレジットカード": 0,
         "銀行振込": 1 
         
     }
    
end