require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録できる場合" do
      it 'nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、
          last_name_kanaとfirst_name_kana、birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context "新規登録できない場合" do
      it 'nicknameが空では登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailは存在できない' do
        @user.save
        user = FactoryBot.build(:user)
        user.email = @user.email
        user.valid?
        expect(user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = "mmmmm"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = "ooo000"
        @user.password_confirmation = "eee000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordは6文字以上でないと登録できない' do
        @user.password = "ooo00"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordは半角でないと登録できない' do
        @user.password = "３３３hhh"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字を含めてください")
      end
      it 'passwordは英字のみでは登録できない' do
        @user.password = "uuuuuu"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字を含めてください")
      end
      it 'passwordは数字のみでは登録できない' do
        @user.password = "333333"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字を含めてください")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = "ooo"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name は全角で入力してください")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = "ooo"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name は全角で入力してください")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaは全角（カタカナ）でないと登録できない' do
        @user.last_name_kana = "さとう"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana は全角カナで入力してください")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaは全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = "あい"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角カナで入力してください")
      end
      it 'birthが空では登録できない' do
        @user.birth = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end