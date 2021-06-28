class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @customer = current_customer
    if current_customer.cart_items.count == 0
      flash[:notice] = 'カートは空です'
      redirect_back(fallback_location: root_path)
    end
  end
    #注文情報確認ページ
  def confirm
    @customer = current_customer
    @order = Order.new
    case params[:payment]
    when '0'
      @payment = 'クレジットカード'
    when '1'
      @payment = '銀行振込'
    end

    case params[:select]
    when '0'
      @p_code = params[:postal_code0]
      @address = params[:address0]
      @name = params[:name0]
    when '1'
      if @customer.shippings.count != 0
        shipping = Shipping.find_by(postal_code: params[:postal_code1])
        @p_code = shipping.postal_code
        @address = shipping.address
        @name = shipping.name
      else
        flash[:notice] = '配送先は登録されていません'
        render :new
      end
    when '2'
      if params[:postal_code2].blank? || params[:address2].blank? || params[:name2].blank?
        flash[:notice] = '選択されたフォームに空欄があります'
        render :new
      else
        @p_code = params[:postal_code2]
        @address = params[:address2]
        @name = params[:name2]
      end
    end

    @amount = 0
    @cart_items = @customer.cart_items
    @tax = 1.08
    @ship = 800
    
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_fee = @ship
    @tax = 1.08
    if @order.save
      # カート内商品の種類の数だけ@ordered_productを作ってカラムに値入れて全部save、その後カート内全削除
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_p|
      @ordered_product = OrderedProduct.new(
          order_id: @order.id,
          product_id: cart_p.product_id,
          amount: cart_p.amount,
          taxed_price: cart_p.product.price.to_i*@tax
        )
        @ordered_product.save
      end
      @cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      flash[:notice] = '注文を確定できませんでした'
      redirect_to new_order_path
    end

  end

  

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @orders = current_customer.orders
    @ordered_products = @order.ordered_products
    @tax = 1.08
    @ship = 800
  end

  def thanks
  end
  
 

  private

  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name, :amount)
  end

end