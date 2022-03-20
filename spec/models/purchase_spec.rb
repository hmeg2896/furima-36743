require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe '商品購入機能' do
    before do
      @purchase = FactoryBot.build(:purchase_address)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        #binding.pry
        expect(@purchase).to be_valid
      end
      it '建物名の値が空でも保存できること' do
        @purchase.building_name = ''
        expect(@purchase).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空では登録できない' do
        @purchase.postal_code = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid")
      end
      it '郵便番号のフォーマットが◯◯◯-◯◯◯◯でないと登録できない' do
        @purchase.postal_code = "1234567"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code is invalid")
      end
      it '都道府県が---では登録できない' do
        @purchase.prefecture_id = 0
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空では登録できない' do
        @purchase.city = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空では登録できない' do
        @purchase.address = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空では登録できない' do
        @purchase.phone_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number can't be blank", "Phone number is invalid", "Phone number is too short (minimum is 10 characters)")
      end
      it '電話番号が9桁以下では登録できない' do
        @purchase.phone_number = 12345678
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end
      it '電話番号が12桁以上では登録できない' do
        @purchase.phone_number = 123456789012
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it '電話番号が全角数字、文字では登録できない' do
        @purchase.phone_number = "１あｱa"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end
