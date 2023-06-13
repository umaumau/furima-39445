FactoryBot.define do
  factory :item do
    name {"椅子"}
    content {"商品説明"}
    category_id {"2"}
    condition_id {"2"}
    postage_id {"2"}
    prefecture_id {"2"}
    duration_id {"2"}
    price {Faker::Number.between(from: 300, to: 9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test-image.png'), filename: 'test-image.png')
    end
  end
end
