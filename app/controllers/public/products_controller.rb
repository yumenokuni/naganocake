class Public::ProductsController < ApplicationController
  #顧客側商品ページ

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def product_params
    params.require(:product).permit(:name, :image, :introduction, :price, :genre_id, :is_active)
  end

end
