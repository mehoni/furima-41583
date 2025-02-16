class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は英字と数字の両方を含む必要があります' }
  validates :nickname, presence: true
  validates :last_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字で入力してください' }
  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
  validates :birthday, presence: true

  has_many :items
  has_many :orders
end
