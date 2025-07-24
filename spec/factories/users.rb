FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { 'abc123' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birth_date            { '1990-01-01' }

    trait :invalid_email_format do
      email { 'invalid_email' }
    end

    trait :password_too_short do
      password { '123' }
      password_confirmation { '123' }
    end

    trait :password_letters_only do
      password { 'abcdef' }
      password_confirmation { 'abcdef' }
    end

    trait :password_numbers_only do
      password { '123456' }
      password_confirmation { '123456' }
    end

    trait :missing_last_name_kana do
      last_name_kana { '' }
    end

    trait :kana_not_katakana do
      first_name_kana { 'たろう' }
    end
  end
end