class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end
  
  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    
    @total = 0
    @shipping_cost = 800
    
      # 自分の住所の場合
   if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address 
      @order.name = current_customer.full_name
      
      # 登録済みの配送先の場合
   elsif params[:order][:address_option] == "1"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name
      
      # 新規住所入力の場合
   elsif  params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
   else
      flash[:notice] = "お届先住所を選択してください"
      render :new
   end
  end
  
  def complete
  end
  
  
  # 注文情報保存
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    
    current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
      @order_details = OrderDetail.new #初期化宣言
      @order_details.item_id = cart_item.item_id #商品idを注文商品idに代入
      @order_details.amount = cart_item.amount #商品の個数を注文商品の個数に代入
      @order_details.price = cart_item.item.with_tax_price #消費税込みに計算して代入
      @order_details.order_id =  @order.id #注文商品に注文idを紐付け
      @order_details.production_status = "production_not_possible"
      @order_details.save #注文商品を保存
    end #ループ終わり
    current_customer.cart_items.destroy_all
    redirect_to  orders_complete_path
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def show
  #   @order = Order.find(params[:id])
		# @order_details = @order.order_details
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end