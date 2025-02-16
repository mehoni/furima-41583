FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    shipping_origin_id { 2 }
    city            { '東京都' }
    street_address  { '1-1' }
    building_name   { '東京ハイツ' }
    phone_number    { '09012345678' }
    token           { 'tok_abcdefghijk00000000000000000' }
  end
end
