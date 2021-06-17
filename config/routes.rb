Rails.application.routes.draw do

  devise_for :customers
  root to: "public/homes#top"
  get "/about" => "public/homes#about", as: 'about'


  # 顧客側ルーティング
  namespace :public do
  end

 # 管理者側ルーティング ヤマタツ追記
   devise_for :admin, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admin do
    resources :products, only: [:index, :show, :new, :create, :edit, :update] #商品情報
    resources :customers, only: [:index, :show, :edit, :update]               #ユーザー情報
    resources :genres, only: [:index, :create, :edit, :update]                #ジャンル
    resources :orders, only: [:index, :show, :update]                         #注文
    resources :order_products, only: [:update]                                #制作ステータスを更新
    get '/admins' => 'admins#top'                                             #管理者のトップ画面
    get 'search' => 'products#search'
  end
  # 管理者側ルーティング
  
end
