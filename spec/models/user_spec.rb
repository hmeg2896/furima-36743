require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'user_name,email,password,password_confirmation,last_name,first_name,last_name_kana,first_name_kana,birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'user_nameが空では登録できない' do
        @user.user_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは不正な値です", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください", "苗字は不正な値です")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前は不正な値です")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カタカナ)を入力してください", "苗字(カタカナ)は不正な値です")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カタカナ）を入力してください", "名前（カタカナ）は不正な値です")
      end
      it 'birthが空では登録できない' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'emaiは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'passwordが五文字以下では登録できない' do
        @user.password = '123qa'
        @user.password_confirmation = '123qa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以内で入力してください")
      end
      it 'passwordは半角英数字混合でないと登録できない(英字のみ)' do
        @user.password = 'qwerty'
        @user.password_confirmation = 'qwerty'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'passwordは半角英数字混合でないと登録できない(数字のみ)' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'passwordは半角でなければ登録できない(全角)' do
        @user.password = 'Ａbc123'
        @user.password_confirmation = 'Ａbc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'last_nameが全角文字でなければ登録できない' do
        @user.last_name = 'tetuto'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は不正な値です")
      end
      it 'first_nameが全角文字でなければ登録できない' do
        @user.first_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は不正な値です")
      end
      it 'last_name_kanaが全角カタカナでなければ登録できない' do
        @user.last_name_kana = 'ややや'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カタカナ)は不正な値です")
      end
      it 'first_name_kanaが全角カタカナでなければ登録できない' do
        @user.first_name_kana = 'ﾔﾔﾔ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カタカナ）は不正な値です")
      end
    end
  end
end
