FactoryBot.define do
  factory :order_address do
    post_code              { '123-4567' }
    prefecture_id          { 2 }
    city                   { '京都市伏見区' }
    block                  { '1-2-3' }
    building_name          { '京都ビル' }
    phone_number           { '1234567890' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
