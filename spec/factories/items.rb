FactoryBot.define do
  factory :item do
    title                     { Faker::Commerce.product_name }
    description               { Faker::Lorem.paragraph }
    price                     { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id               { Faker::Number.between(from: 2, to: 10) } # ActiveHashで「1」がプレースホルダーの場合
    condition_id              { Faker::Number.between(from: 2, to: 10) }
    shipping_cost_id          { Faker::Number.between(from: 2, to: 10) }
    shipping_origin_id        { Faker::Number.between(from: 2, to: 10) }
    shipping_date_estimate_id { Faker::Number.between(from: 2, to: 10) }
    association :user # 関連するUserモデルのファクトリを紐付け

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample_image.png')), filename: 'sample_image.png',
                        content_type: 'image/png')
    end
  end
end
