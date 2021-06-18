Rails.application.routes.draw do

  root to: "public/homes#top"
  get "/about" => "public/homes#about", as: 'about'


  # 顧客側ルーティング
  namespace :public do
    resources :products, only: [:index, :show]
  end

  # 管理者側ルーティング
  namespace :admin do
    resources :products
  end

end