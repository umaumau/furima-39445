FactoryBot.define do
  factory :user do
    nickname { "nickname" }
    email { Faker::Internet.email }
    password { "000jjj" }
    password_confirmation { password }
    last_name { "佐藤" }
    first_name { "あい" }
    last_name_kana { "サトウ" }
    first_name_kana { "アイ" }
    birth { Date.new(1999, 10, 13) }
  end
end