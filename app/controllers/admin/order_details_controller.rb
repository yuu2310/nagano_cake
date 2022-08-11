class Admin::OrderDetailsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def update
    @order_detail = OrderDetail.find(params[:id]) #注文商品の特定
    @order = @order_detail.order  #注文商品から注文テーブルの呼び出し
    @order_detail.update(order_detail_params)  #製作ステータスの更新
    
		if @order_detail.production_status == "in_production" #製作ステータスが「製作中」なら
			@order.update(status: "in_production") #注文ステータスを「製作中」　に更新
		elsif @order.order_details.count ==  @order.order_details.where(production_status: "production_complete").count #注文した商品の個数と製作完了した商品の個数が一致した場合
		  @order.update(status: "preparing_delivery") #注文ステータスを「発送準備中]に更新
		end
      redirect_to admin_order_path(@order_detail.order.id), notice: "制作ステータスを更新しました"
  end
  
  private
  
  def order_detail_params
     params.require(:order_detail).permit(:production_status)
  end
  
end



#注文商品の制作ステータスorder_detailの情報を注文情報であるorderで呼び出そうとしたため制作ステータスを更新すると、注文商品が消えてしまったようになった
