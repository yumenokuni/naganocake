class Admin::ProductsController < ApplicationController
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to admin_products_path(@product)
  end

  def index
    @products = Product.all
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
    redirect_to admin_products_path(@product)
  end
  
  private

  def product_params
    params.require(:product).permit(:name, :image, :introduction, :price)
  end
  
end
