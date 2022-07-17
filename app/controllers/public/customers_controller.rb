class Public::CustomersController < ApplicationController
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to customers_my_page_path(customer.id)  
  end
  
  def unsubscribe
  end
  
  def withdraw
    @customer = current_customer
    if @customer.update(is_deleted: true)
      reset_session
      flash[:notice] = "退会処理を実行しました"
      redirect_to root_path
    end
  end

private 

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
