class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  
  # validates :genru_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  
  def with_tax_price
    (price * 1.1).floor
  end
  
  def get_image(size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize: size).processed
  end

  
end