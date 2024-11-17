class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true,
                       format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :nickname, presence: true, length: { maximum: 40 }
  validates :last_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龯々]+\z/ }
  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[ァ-ンー]+\z/ }
  validates :birthday, presence: true
end
