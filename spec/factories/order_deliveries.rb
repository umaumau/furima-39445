FactoryBot.define do
  factory :order_delivery do
    postal_code {"123-4567"}
    prefecture_id {"2"}
    city {"札幌市"}
    address {"2-2-2"}
    building {"ビルディング"}
    phone {"1234567890"}
  end
end
