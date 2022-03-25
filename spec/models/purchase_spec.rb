require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        
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
        expect(@purchase.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は不正な値です")
      end
      it '郵便番号のフォーマットが◯◯◯-◯◯◯◯でないと登録できない' do
        @purchase.postal_code = "1234567"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '都道府県が---では登録できない' do
        @purchase.prefecture_id = 0
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村が空では登録できない' do
        @purchase.city = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("市区町村を入力してください", "市区町村は不正な値です")
      end
      it '番地が空では登録できない' do
        @purchase.address = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空では登録できない' do
        @purchase.phone_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です", "電話番号は10文字以上で入力してください")
      end
      it '電話番号が9桁以下では登録できない' do
        @purchase.phone_number = 12345678
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("電話番号は不正な値です", "電話番号は10文字以上で入力してください")
      end
      it '電話番号が12桁以上では登録できない' do
        @purchase.phone_number = 123456789012
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("電話番号は不正な値です", "電話番号は11文字以内で入力してください")
      end
      it '電話番号が全角数字、文字では登録できない' do
        @purchase.phone_number = "１あｱa"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("電話番号は不正な値です", "電話番号は10文字以上で入力してください")
      end
      it 'tokenが空では登録できない' do
        @purchase.token = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("カード番号を入力してください")
      end
      it 'userと紐付いていないと登録できない'do 
        @purchase.user_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemと紐付いていないと登録できない'do 
        @purchase.item_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
