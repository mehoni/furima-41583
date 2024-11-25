require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '正常系' do
      it '全ての必須項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '異常系' do
      it 'ニックネームがない場合は登録できない' do
        @user.nickname = nil
        expect(@user).to be_invalid
        expect(@user.errors[:nickname]).to include("can't be blank")
      end

      it 'メールアドレスが重複している場合は登録できない' do
        FactoryBot.create(:user, email: @user.email) # 重複メールアドレスを作成
        expect(@user).to be_invalid
        expect(@user.errors[:email]).to include('has already been taken')
      end

      it 'メールアドレスが@を含まない場合は登録できない' do
        @user.email = 'testexample.com'
        expect(@user).to be_invalid
        expect(@user.errors[:email]).to include('is invalid')
      end

      it 'パスワードが空の場合は登録できない' do
        @user.password = nil
        @user.password_confirmation = nil
        expect(@user).to be_invalid
        expect(@user.errors[:password]).to include("can't be blank")
      end

      it 'パスワードが6文字未満の場合は登録できない' do
        @user.password = 'short'
        @user.password_confirmation = 'short'
        expect(@user).to be_invalid
        expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end

      it 'パスワードが数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        expect(@user).to be_invalid
        expect(@user.errors[:password]).to include('は英字と数字の両方を含む必要があります')
      end

      it 'パスワードが全角の場合は登録できない' do
        @user.password = 'ＡＢＣ１２３４５'
        @user.password_confirmation = 'ＡＢＣ１２３４５'
        expect(@user).to be_invalid
        expect(@user.errors[:password]).to include('は英字と数字の両方を含む必要があります')
      end

      it 'パスワードとパスワード確認が一致していない場合は登録できない' do
        @user.password_confirmation = 'DifferentPassword'
        expect(@user).to be_invalid
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it '誕生日が空の場合は登録できない' do
        @user.birthday = nil
        expect(@user).to be_invalid
        expect(@user.errors[:birthday]).to include("can't be blank")
      end

      it '姓名が全角でない場合は登録できない' do
        @user.last_name = 'Yamada'
        @user.first_name = 'Taro'
        expect(@user).to be_invalid
        expect(@user.errors[:last_name]).to include('は全角文字で入力してください')
        expect(@user.errors[:first_name]).to include('は全角文字で入力してください')
      end

      it '姓名（カナ）が全角カナでない場合は登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.first_name_kana = 'たろう'
        expect(@user).to be_invalid
        expect(@user.errors[:last_name_kana]).to include('は全角カタカナで入力してください')
        expect(@user.errors[:first_name_kana]).to include('は全角カタカナで入力してください')
      end
    end
  end
end
