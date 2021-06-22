class Public::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
  
  private

  def product_params
    params.require(:product).permit(:name, :image, :introduction, :price, :genre_id, :is_active)
  end
  
end
