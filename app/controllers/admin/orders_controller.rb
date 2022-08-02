class Admin::OrdersController < ApplicationController
  
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
    order = Order.find(params[:id]) 
    order_details = order.order_details
    order.update(order_params)
    redirect_to admin_order_path(order.id)
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
end
