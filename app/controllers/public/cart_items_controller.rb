class Public::CartItemsController < ApplicationController
  #カート内商品ページ

  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  #カート内に商品を追加
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end

  #カート内の商品データ更新
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  #カート内の商品を1つ削除
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice]='商品を削除しました。'
    redirect_to cart_items_path
  end

  #カート内の商品を全て削除
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
    flash[:notice]='カート内を空にしました。'
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:product_id, :amount)
  end

end
