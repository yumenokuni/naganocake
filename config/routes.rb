Rails.application.routes.draw do

  root to: "public/homes#top"
  get "/about" => "public/homes#about", as: 'about'

 # 管理者側ルーティング ヤマタツ追記
   devise_for :admin, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admin do
    resources :products #商品情報
    resources :customers, only: [:index, :show, :edit, :update]               #ユーザー情報
    resources :genres, only: [:index, :create, :edit, :update]                #ジャンル
    resources :orders, only: [:index, :show, :update]                         #注文
    resources :order_products, only: [:update]                                #制作ステータスを更新
    get '/admins' => 'admins#top'                                             #管理者のトップ画面
    get 'search' => 'products#search'

  end
  
  # 顧客側ルーティング あやかさん追記
  scope module: "public" do
    devise_for :customers, controllers: {
    sessions: 'public/customers/sessions',  #
    paswords: 'public/customers/paswords',
    registrations: 'public/customers/registrations',
  }
  end

  resources :shippings ,only: [:index,:create,:edit,:update,:destroy]
  resources :products, only: [:index, :show]# 顧客側商品

end