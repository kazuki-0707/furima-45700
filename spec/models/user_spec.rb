require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '登録できるとき' do
      it 'すべての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors[:nickname]).to include("can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      it 'emailが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("has already been taken")
      end

      it 'emailに@が含まれていなければ登録できない' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors[:email]).to include("is invalid")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        @user.valid?
        expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end

      it 'passwordが英字のみの場合は登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors[:password]).to include("is invalid. Include both letters and numbers")
      end

      it 'passwordが数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors[:password]).to include("is invalid. Include both letters and numbers")
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password_confirmation = 'different'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors[:last_name]).to include("can't be blank")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors[:first_name]).to include("can't be blank")
      end

      it 'last_nameが全角でないと登録できない' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors[:last_name]).to include("is invalid. Input full-width characters")
      end

      it 'first_nameが全角でないと登録できない' do
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors[:first_name]).to include("is invalid. Input full-width characters")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include("can't be blank")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include("can't be blank")
      end

      it 'last_name_kanaが全角カタカナでないと登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include("is invalid. Input full-width katakana characters")
      end

      it 'first_name_kanaが全角カタカナでないと登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include("is invalid. Input full-width katakana characters")
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors[:birth_date]).to include("can't be blank")
      end
    end
  end
end
