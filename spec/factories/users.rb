FactoryBot.define do
  factory :user do
    user_name             {Faker::Name.name}
    email                 {Faker::Internet.email}
    password = Faker::Internet.password(min_length: 6)
    password              {password}
    password_confirmation {password}
    japanese_user = Gimei.name
    last_name             {japanese_user.last.kanji}
    first_name            {japanese_user.first.kanji}
    last_name_kana        {japanese_user.last.katakana}
    first_name_kana       {japanese_user.first.katakana}
    birth                 {Faker::Date.birthday}
  end
end