class Public::CartItemsController < ApplicationController
  
  before_action :authenticate_customer!
  before_action :cart_item_item, only: [:create]
  
  def index
    @cart_items = current_customer.cart_items.all
    @total = 0
  end
  
  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path, notice: "#{cart_item.item.name}を削除しました"
  end
  
  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
    redirect_to cart_items_path, notice: "カートの商品を全て削除しました"
  end
  
  def create
    if current_customer.cart_items.exists?(item_id: params[:cart_item][:item_id]) #cart_itemモデルのフォームからの投稿されたitem_id商品を探す
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) #商品のidを使ってカート内に同じ商品があるか探す。find_byは別のカラムが使える。
      total = cart_item.amount +  params[:cart_item][:amount].to_i #すでにカートにある商品の個数と新しくカートに追加された商品の個数を足す。
      cart_item.update(amount: total) #足したものを保存
    elsif
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
    end
      redirect_to cart_items_path, notice: "#{@cart_item.item.name}をカートに追加しました。"
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id, :image)
  end
  
  def cart_item_item
		redirect_to item_path(params[:cart_item][:item_id]), notice: "個数を選択してください" if params[:cart_item][:amount].empty?
	end

end


