class Admin::ProductsController < ApplicationController
  #管理者側商品ページ

  before_action :authenticate_admin!
  before_action :set_genres, only: [:new, :edit, :index, :create, :update]

  def new
    @product = Product.new
    @genres = Genre.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
    redirect_to admin_product_path(@product)
    else
      render :new
    end
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    @genres = Genre.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = '商品の内容を変更しました。'
      redirect_to admin_product_path(@product)
    else
      render :edit
    end
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
