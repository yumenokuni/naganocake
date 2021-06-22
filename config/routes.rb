Rails.application.routes.draw do


  get "/about" => "public/homes#about", as: 'about'

 # 管理者側deviseルーティング ヤマタツ追記
   devise_for :admin, controllers: {
    sessions:      'admin/sessions',                                        #adminsのsを削除しました
    passwords:     'admin/passwords',
    registrations: 'admin/registrations'
  }

  # 管理者側ルーティング ヤマタツ追記
  namespace :admin do
    resources :products                                                       #商品情報
    resources :customers, only: [:index, :show, :edit, :update]               #ユーザー情報
    resources :genres, only: [:index, :create, :edit, :update, :destroy]      #ジャンル
    resources :orders, only: [:index, :show, :update]                         #注文
    resources :order_products, only: [:update]                                #制作ステータスを更新
    get 'admin' => 'homes#top'                                             #管理者のトップ画面
    get 'search' => 'products#search'
  end
 root to: "public/homes#top"
  # 顧客側ルーティング
  scope module: "public" do
    get '/customers/my_page' => 'customers#show', as: 'my_page'               #ユーザーマイページ
    get '/customers/unsubscribe' => "customers#unsubscribe"                   #ユーザー退会
    patch '/customers/withdraw' => "customers#withdraw"                       #ユーザーステータス更新
    delete '/cart_items/destroy_all' => "cart_items#destroy_all"              #カート内商品全削除
    resource :customers, only: [:edit, :update]                               #ユーザー情報
    resources :cart_items, only: [:index, :create, :update, :destroy]         #カート内商品
    resources :shippings, only: [:index,:create,:edit,:update,:destroy]       #配送先情報
    resources :products, only: [:index, :show]                                #顧客側商品

    #顧客側devise
    devise_for :customers, controllers: {
      sessions: 'public/customers/sessions',
      paswords: 'public/customers/paswords',
      registrations: 'public/customers/registrations',
    }
  end



  resources :products, only: [:index, :show]                                  #顧客側商品


  resources :orders, only: [:new, :create, :show, :index]
  post "/orders/confirm" => "orders#confirm"
  get "/orders/thanks" => "orders#thanks"
end
