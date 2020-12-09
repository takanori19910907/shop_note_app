FactoryBot.define do
  factory :favorite_item do
    sequence(:name) { |n| "test_item#{n}" }
    association :user
  end
end
