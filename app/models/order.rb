class Order < ApplicationRecord
  
  belongs_to :customer
  has_many :order_details
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  enum status: { 
    payment_waiting: 0, 
    payment_confirmation: 1, 
    in_production: 2, 
    preparing_delivery: 3, 
    delivered: 4 
  }
  
  validates :payment_method, presence: true
  
 
  
  def count_amount
    total = 0
    order_details.each do |order_detail|
      total += order_detail.amount
    end
    return total
  end
  
end
