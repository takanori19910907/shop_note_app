FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "たかのり#{n}" }
    sequence(:email) { |n| "test#{n}@example.com"}
    password { "password" }
  end
  factory :other_user do
    sequence(:name) { |n| "テストユーザー#{n}" }
    sequence(:email) { |n| "test#{n}@example.com"}
    password { "passwoad" }
  end
end
