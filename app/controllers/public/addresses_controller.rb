class Public::AddressesController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @addresses = current_customer.addresses
    @customer = 
    @address = Address.new
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
   if @address.save
     redirect_to addresses_path, notice: "配送先を新規登録しました"
   else
     @addresses = Address.all
     render :index
   end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先を更新しました"
    else
      render :edit
    end
  end
  
  def destroy
    address = Address.find(params[:id])  
    address.destroy
    redirect_to  addresses_path, notice: "削除しました"
  end
  
  private
  
  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :customer_id)
  end
end
