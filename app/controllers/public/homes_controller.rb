class Public::HomesController < ApplicationController
  
  def top
    @items = Item.where(is_active: "販売中").order('id DESC').limit(4)
    #販売ステータスが販売中の商品のみ表示
    #新着順の商品を4つ表示
  end
  
  def about
  end
  
end
