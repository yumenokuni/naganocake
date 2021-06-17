Rails.application.routes.draw do

  root to: "public/homes#top"
  get "/about" => "public/homes#about", as: 'about'


  # 顧客側ルーティング
  namespace :public do
  end

  # 管理者側ルーティング
  namespace :admin do
  end

  resources :shippings ,only: [:index,:create,:edit,:update,:destroy]
  post 'shippings' => 'shippings#create'
end
