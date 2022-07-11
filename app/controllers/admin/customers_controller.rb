class Admin::CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
  end
  
  def edit
  end
  
  def update
  end
  
  def show
  end
    
end
