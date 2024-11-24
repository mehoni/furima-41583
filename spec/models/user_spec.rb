require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    let(:valid_attributes) do
      {
        nickname: 'test',
        email: 'test@example.com',
        password: 'Password1',
        password_confirmation: 'Password1',
        last_name: '山田',
        first_name: '太郎',
        last_name_kana: 'ヤマダ',
        first_name_kana: 'タロウ',
        birthday: '1990-01-01'
      }
    end

    let(:user) { User.new(valid_attributes) }

    before do
      User.create!(valid_attributes)
    end

    context '正常系' do
      it '全ての必須項目が正しく入力されていれば登録できる' do
        new_user = User.new(
          nickname: 'new_test',
          email: 'new_test@example.com',
          password: 'Password2',
          password_confirmation: 'Password2',
          last_name: '佐藤',
          first_name: '花子',
          last_name_kana: 'サトウ',
          first_name_kana: 'ハナコ',
          birthday: '1992-02-02'
        )
        expect(new_user).to be_valid
      end
    end

    context '異常系' do
      it 'ニックネームがない場合は登録できない' do
        user.nickname = nil
        expect(user).to be_invalid
        expect(user.errors[:nickname]).to include("can't be blank")
      end

      it 'メールアドレスが重複している場合は登録できない' do
        duplicate_user = User.new(valid_attributes)
        expect(duplicate_user).to be_invalid
        expect(duplicate_user.errors[:email]).to include('has already been taken')
      end

      it 'メールアドレスが@を含まない場合は登録できない' do
        user.email = 'testexample.com'
        expect(user).to be_invalid
        expect(user.errors[:email]).to include('is invalid')
      end

      it 'パスワードが空の場合は登録できない' do
        user.password = nil
        user.password_confirmation = nil
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("can't be blank")
      end

      it 'パスワードが6文字未満の場合は登録できない' do
        user.password = 'short'
        user.password_confirmation = 'short'
        expect(user).to be_invalid
        expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end

      it 'パスワードが半角英数字混合でない場合は登録できない' do
        user.password = 'password'
        user.password_confirmation = 'password'
        expect(user).to be_invalid
        expect(user.errors[:password]).to include('は英字と数字の両方を含む必要があります')
      end

      it 'パスワードとパスワード確認が一致していない場合は登録できない' do
        user.password_confirmation = 'DifferentPassword'
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it '誕生日が空の場合は登録できない' do
        user.birthday = nil
        expect(user).to be_invalid
        expect(user.errors[:birthday]).to include("can't be blank")
      end
    end
  end
end
