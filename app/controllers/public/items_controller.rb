class Public::ItemsController < ApplicationController
  
  before_action :authenticate_customer!, except:[:index]
  
  
  
  def index
    @items = Item.where(is_active: "販売中").page(params[:page]).per(8)
    #販売ステータスが販売中の商品のみ表示
  end
  
  def show
    @item =Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def search
  end
  
  private
  
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end
 
end
