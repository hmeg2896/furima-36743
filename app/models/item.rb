class Item < ApplicationRecord

  validates :product, presence: true
  validates :product_description, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :postage_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_date_id, presence: true
  validates :price, presence: true, numericality: { less_than_or_equal_to: 9999999, 
    greater_than_or_equal_to: 300 }
  validates :image, presence: true

  belongs_to :user
  has_many :comments
  has_one :order
  has_one_attached :image
end
