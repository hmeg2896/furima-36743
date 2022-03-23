FactoryBot.define do
  factory :purchase_address do
    postal_code { "411-0044" }
    prefecture_id { Faker::Number.between(from: 1, to: 48) }
    city { "三島市" }
    address { "徳倉2-4" }
    building_name { "セボージャ" }
    phone_number { "0#{rand(0..9)}0#{rand(1_000_000..99_999_999)}" }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
