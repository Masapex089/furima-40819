FactoryBot.define do
  factory :item do
    name             { 'humberger' }
    explanation      { Faker::Lorem.sentence }
    price            { 10_000 }
    category_id      { 2 }
    item_status_id   { 2 }
    delivery_fee_id  { 2 }
    prefecture_id    { 2 }
    delivery_day_id { 2 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
