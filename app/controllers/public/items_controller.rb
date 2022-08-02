class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all.page(params[:page]).per(8)
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
