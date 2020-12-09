FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "test_group#{n}" }
  end
end
