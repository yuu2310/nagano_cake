class Admin::OrderDetailsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    # @order = @order_detail.order
    @order_detail.update(order_detail_params)
   
    
    
   
    # #byebug
    # @order_details = @order.order_details
   

    # if @order_details.where(production_status: "製作中").count >= 1
    #   @order.status = "製作中"
    #   @order.save
    # end

    # if @order.order_details.count == @order_details.where(production_status: "製作完了").count
    #   @order.status = "発送準備中"
    #   @order.save
    # end
     redirect_to admin_order_path(@order_detail.order.id), notice: "制作ステータスを更新しました"
  end
  
  private
  
  def order_detail_params
     params.require(:order_detail).permit(:production_status)
  end
  
end



#注文商品の制作ステータスorder_detailの情報を注文情報であるorderで呼び出そうとしたため制作ステータスを更新すると、注文商品が消えてしまったようになった
