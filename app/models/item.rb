class Item < ApplicationRecord

  validates :product, presence: true, length: { maximum: 40}
  validates :product_description, presence: true, length: { maximum: 1000}
  validates :category_id, presence: true, numericality: { other_than: 0 , message: "can't be blank"}
  validates :condition_id, presence: true, numericality: { other_than: 0 , message: "can't be blank"}
  validates :postage_id, presence: true, numericality: { other_than: 0 , message: "can't be blank"}
  validates :prefecture_id, presence: true, numericality: { other_than: 0 , message: "can't be blank"}
  validates :shipping_date_id, presence: true, numericality: { other_than: 0 , message: "can't be blank"}
  validates :price, presence: true, 
             numericality: { less_than_or_equal_to: 9999999, greater_than_or_equal_to: 300 }, 
             length: { minimum: 3, maximum: 7 }, 
             format: { with: /\A[0-9]+\z/ }
  validates :image, presence: true

  belongs_to :user
  # has_many :comments
  has_one :order
  
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipping_date

end
