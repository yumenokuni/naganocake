class Public::HomesController < ApplicationController

  #TOP画面に新着商品を表示する
  def top
    @products = Product.all.order(created_at: :desc).limit(4)
  end

  def about
  end

end
