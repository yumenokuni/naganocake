class Public::ShippingsController < ApplicationController
 #顧客側注文ページ

  before_action :authenticate_customer!

 def index
    @shipping = Shipping.new
    @shippings = current_customer.shippings
 end

 def create
    shipping = Shipping.new(shipping_params)
    shipping.customer_id = current_customer.id
    shipping.save
    redirect_to shippings_path
    flash[:notice]='配送先情報を追加しました。'
 end

 def edit
    @shipping = Shipping.find(params[:id])
 end

 def update
    @shipping = Shipping.find(params[:id])
    @shipping.update(shipping_params)
    redirect_to shippings_path
    flash[:notice]='配送先情報を修正しました。'
 end

 def destroy
    @shipping = Shipping.find(params[:id])
    @shipping.customer = current_customer
    @shipping.destroy
    redirect_to shippings_path
    flash[:notice]='配送先を削除しました。'
 end

  private
  def shipping_params
    params.require(:shipping).permit(:postal_code,:address,:name)
  end
end