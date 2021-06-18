class Admin::ProductsController < ApplicationController
  def new
    @product = Product.new
  end
  
  def create
    @product = PostImage.new(product_params)
    @product.save
    redirect_to admin_products_path
  end

  def index
    @products = product.all
  end

  def show
    @product = Product.find(params[:id])
  end
  
  def edit
    @product = Product.find(params[:id])
    redirect_to admin_products_path
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end
  
  private

  def product_params
    params.require(:product).permit(:name, :image, :introduction, :price)
  end
  
end
