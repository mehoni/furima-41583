require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    # ニックネームが必須であること
    it 'is invalid without a nickname' do
      user = User.new(nickname: nil)
      expect(user).to be_invalid
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # メールアドレスが必須であること
    it 'is invalid with a duplicate email' do
      # 必須フィールドを入力
      user1 = User.create!(nickname: 'test', email: 'test@example.com', password: 'Password1', password_confirmation: 'Password1',
                           last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birthday: '1990-01-01')
      user2 = User.new(nickname: 'test', email: 'test@example.com', password: 'Password1', password_confirmation: 'Password1',
                       last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birthday: '1990-01-01')
      expect(user2).to be_invalid
      expect(user2.errors[:email]).to include('has already been taken')
    end

    # メールアドレスが一意性であること
    it 'is invalid with a duplicate email' do
      # 最初のユーザー作成（重複するメールアドレスを使用）
      user1 = User.create!(nickname: 'test', email: 'test@example.com', password: 'Password1', password_confirmation: 'Password1',
                           last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birthday: '1990-01-01')

      # 2番目のユーザー作成（メールアドレスが重複している）
      user2 = User.new(nickname: 'test2', email: 'test@example.com', password: 'Password2', password_confirmation: 'Password2',
                       last_name: '佐藤', first_name: '花子', last_name_kana: 'サトウ', first_name_kana: 'ハナコ', birthday: '1992-02-02')

      # 重複したメールアドレスでユーザーが作成できないことを確認
      expect(user2).to be_invalid
      expect(user2.errors[:email]).to include('has already been taken')
    end

    # メールアドレスは@を含む必要があること
    it 'is invalid with an email without @ symbol' do
      user = User.new(email: 'testexample.com', password: 'Password1', password_confirmation: 'Password1')
      expect(user).to be_invalid
      expect(user.errors[:email]).to include('is invalid')
    end

    # パスワードが必須であること
    it 'is invalid without a password' do
      user = User.new(password: nil, password_confirmation: nil)
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("can't be blank")
    end

    # パスワードは6文字以上であること
    it 'is invalid with a password shorter than 6 characters' do
      user = User.new(password: 'short', password_confirmation: 'short')
      expect(user).to be_invalid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end

    # パスワードは半角英数字混合であること
    it 'is invalid with a password that does not contain both letters and numbers' do
      user = User.new(password: 'password', password_confirmation: 'password')
      expect(user).to be_invalid
      expect(user.errors[:password]).to include('は英字と数字の両方を含む必要があります')
    end

    # パスワードとパスワード（確認）が一致していること
    it 'is invalid if password and password_confirmation do not match' do
      user = User.new(password: 'Password1', password_confirmation: 'DifferentPassword')
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end
end
