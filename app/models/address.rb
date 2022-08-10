class Address < ApplicationRecord
  
  belongs_to :customer
  
  validates :postal_code, presence: true, numericality: :only_integer
  validates :address, presence: true
  validates :name, presence: true
  
  def view_address
    postal_code + " " + address + " " + name
  end
end
