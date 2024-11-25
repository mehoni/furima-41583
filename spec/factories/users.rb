FactoryBot.define do
  factory :user do
    nickname { 'test' }
    email { Faker::Internet.unique.email }
    password { 'Password1' }
    password_confirmation { 'Password1' }
    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birthday { '1990-01-01' }
  end
end
