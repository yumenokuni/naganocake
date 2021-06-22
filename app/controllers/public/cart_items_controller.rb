class Public::CartItemsController < ApplicationController
  #カート内商品ページ

  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def create
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

end
