class ShippingsController < ApplicationController

 def index
    @shipping = Shipping.new
 end

 def create
    shipping = Shipping.new(shipping_params)
    shipping.save
    redirect_to shippings_path
 end

 def edit
    @shipping = Shipping.find(params[:id])
 end

 def destroy
    @shipping = Shipping.find(params[:id])
    @shipping.user = current_user
    @shipping.destroy
 end

 def update
    @shipping = Shipping.find(params[:id])
 end

  private
  def shipping_params
    params.require(:shipping).permit(:postal_code,:address,:name)
  end
end