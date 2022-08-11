class Admin::OrdersController < ApplicationController
  
   before_action :authenticate_admin!
  
  def index
    @orders = Order.all.page(params[:page])
  end
  
  def show
    @order = Order.find(params[:id])
		@order_details = @order.order_details
		@total = 0
		@shipping_cost = 800
  end
  
  def update
    @order = Order.find(params[:id])  #注文詳細の特定
    @order.update(order_params) #注文ステータスの更新
    @order_details = @order.order_details #注文から紐付く注文した商品の取得

 	 if @order.status == "payment_confirmation" #注文ステータスが「入金確認」なら
	    @order_details.update_all(production_status: "production_pending") #製作ステータスを「製作待ち」に更新
	 end
    redirect_to admin_order_path(@order.id), notice: "注文ステータスを更新しました"
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
end