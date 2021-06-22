class Public::Customers::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @customer = current_customer
    if current_customer.cart_products.count == 0
      flash[:notice] = "カートは空です"
      redirect_back(fallback_location: root_path)
    end
  end

  def confirm
    @customer = current_customer
    @order = Order.new
    case params[:how_to_pay]
    when "0"
      @how_to_pay = "クレジットカード"
    when "1"
      @how_to_pay = "銀行振込"
    end

    case params[:select]
    when "0"
      @p_code = params[:postal_code0]
      @address = params[:address0]
      @name = params[:receiver_name0]
    when "1"
      if @customer.receivers.count != 0
        receiver = Receiver.find_by(postal_code: params[:postal_code1])
        @p_code = receiver.postal_code
        @address = receiver.address
        @name = receiver.name
      else
        flash[:notice] = "配送先は登録されていません"
        render :new
      end
    when "2"
      if params[:postal_code2].blank? || params[:address2].blank? || params[:receiver_name2].blank?
        flash[:notice] = "選択されたフォームに空欄があります"
        render :new
      else
        @p_code = params[:postal_code2]
        @address = params[:address2]
        @name = params[:receiver_name2]
      end
    end

    @total_price = 0
    @cart_products = @customer.cart_products
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = $ship
    if @order.save
      # カート内商品の種類の数だけ@ordered_productを作ってカラムに値入れて全部save、その後カート内全削除
      @cart_products = current_customer.cart_products
      @cart_products.each do |cart_p|
        @ordered_product = OrderedProduct.new(
          order_id: @order.id,
          product_id: cart_p.product_id,
          count: cart_p.count,
          tax_included_price: cart_p.product.price*$tax
        )
        @ordered_product.save
      end
      @cart_products.destroy_all
      redirect_to orders_finish_path
    else
      flash[:notice] = "注文を確定できませんでした"
      redirect_to new_orders_path
    end

  end

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_products = @order.ordered_products
  end

  def redirect
    redirect_to new_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:how_to_pay, :postal_code, :address, :receiver_name, :total_payment)
  end

end