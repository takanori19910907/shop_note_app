FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "comment#{n}" }
    association :user
    association :note
  end
end
