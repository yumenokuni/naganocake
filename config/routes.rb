Rails.application.routes.draw do

  root to: "public/homes#top"
  get "/about" => "public/homes#about", as: 'about'


  # 顧客側ルーティング
  namespace :public do
  end

  # deviseの顧客側ルーティング設定
  scope module: "public" do
    devise_for :customers, controllers: {
    sessions: 'public/customers/sessions',  #
    paswords: 'public/customers/paswords',
    registrations: 'public/customers/registrations',
  }
  end

  resources :shippings ,only: [:index,:create,:edit,:update,:destroy]
  post 'shippings' => 'shippings#create'
end
