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
    @order = Order.find(params[:id]) 
    @order.update(order_params)
    @order_details = @order.order_details
    
    # if @order.status == "入金確認"
    #   @order_details.each do |order_detail|
    #     order_detail.production_status = "製作待ち"
    #     order_detail.save
    #   end
    # end
    redirect_to admin_order_path(@order.id), notice: "注文ステータスを更新しました"
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
end