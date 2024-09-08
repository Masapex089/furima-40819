FactoryBot.define do
  factory :user do
    nickname              { Faker::Name }
    email                 { Faker::Internet.email }
    password              { 'test1234' }
    password_confirmation { password }
    first_name_kanji      { '山田' }
    last_name_kanji       { '陸太郎' }
    first_name_kana       { 'ヤマダ' }
    last_name_kana        { 'リクタロウ' }
    birthday              { '1993-01-01' }
  end
end
