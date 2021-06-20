class Admin::ProductsController < ApplicationController
  before_action :set_genres, only: [:new, :edit, :index, :create, :update]
  
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
    params.require(:product).permit(:name, :image, :introduction, :price, :genre_id, :is_active)
  end
  
  def set_genres
    @genres = Genre.where(name: true)
  end
  
end
