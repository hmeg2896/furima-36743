class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  
    validates :user_name, presence: true
    validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX}

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/} do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/} do
    validates :last_name_kana
    validates :first_name_kana
  end

    validates :birth, presence: true

  has_many :items
  has_many :comments
  has_many :orders
  
end
