class Admin::OrdersController < ApplicationController
  #管理者側注文ページ

  before_action :authenticate_admin!

  def index
    @customer = Customer.find_by(id: params[:customer_id])
    if @customer.nil? #カスタマーが空白(存在しない)かったら
      @orders = Order.all.page(params[:page]).per(10)
    else
      @orders = @customer.orders.page(params[:page]).per(10)
    end

  end

  def show
    @order = Order.find(params[:id])
    @ordered_products = @order.ordered_products
  end

  def update
    @order = Order.find(params[:id])
    @ordered_products = @order.ordered_products
    if @order.update(order_params)
      if @order.order_status == 1
        @ordered_products.each do |prod|
          prod.update(production_status: 1)
        end
        flash[:notice] = '注文ステータスが「入金確認」となったため、制作ステージが「制作待ち」に自動更新されました。'
      else
        flash[:notice] = '注文ステータスを変更しました。'
      end
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = '注文ステータスを変更できませんでした。'
      render :show
    end

  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end