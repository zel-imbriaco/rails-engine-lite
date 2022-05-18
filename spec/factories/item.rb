FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
    unit_price { Faker::Commerce.price }
  end
end