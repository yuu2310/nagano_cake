class Public::AddressesController < ApplicationController
  
  def index
    @addresses = Address.all
    @address = Address.new
  end
  
  def create
    address = Address.new(address_params)
    address.customer_id = current_customer.id
   if address.save
    flash[:notice] = "配送先を新規登録しました"
     redirect_to addresses_path
   else
     @addresses = Address.all
     @address = Address.new
     flash[:notice] = "配送先の新規登録に失敗しました"
     render :index
   end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to addresses_path
  end
  
  def destroy
    address = Address.find(params[:id])  
    address.destroy
    redirect_to  addresses_path
  end
  
  private
  
  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :customer_id)
  end
end
