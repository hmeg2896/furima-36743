class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :item_id, :user_id, :order_id, :token
  
  with_options presence: true do
    validates :postal_code,format: { with: /\A\d{3}[-]\d{4}\z/}
    validates :prefecture_id,numericality: {other_than: 0, message: "を選択してください"}
    validates :city,format: { with: /\A[一-龥ぁ-ん]/}
    validates :address
    validates :phone_number,format: { with: /\A\d{10,11}\z/},length: { minimum: 10, maximum: 11 }
    validates :user_id
    validates :item_id
    validates :token
  end
  
    
  
  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Purchase.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end