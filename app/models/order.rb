class Order < ApplicationRecord
  has_one :purchase
  has_one :item
  belongs_to :user
end
