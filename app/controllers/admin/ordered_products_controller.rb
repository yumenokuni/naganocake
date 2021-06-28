class Admin::OrderedProductsController < ApplicationController
  #管理者側注文詳細ページ

 before_action :authenticate_admin!

  def update
    @ordered_product = OrderedProduct.find(params[:id])
    @order = @ordered_product.order
    if @ordered_product.update(prod_params)
      if @ordered_product.making_status == 2
        @order.update(order_status: 2)
        flash[:notice] = '制作ステータスが「製作中」となったため注文ステータスが「製作中」に更新されました。'
      elsif @order.ordered_products.count == @order.ordered_products.where(making_status: 3).count
        @order.update(order_status: 3)
        flash[:notice] = '制作ステータスが全て「製作完了」となったため注文ステータスが「発送準備中」に更新されました。'
      else
        flash[:notice] = '制作ステータスを変更しました。'
      end
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def prod_params
    params.require(:ordered_product).permit(:making_status)
  end

end