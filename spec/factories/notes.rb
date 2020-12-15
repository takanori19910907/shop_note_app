FactoryBot.define do
  factory :note do
    sequence(:content) { |n| "買うもの#{n}" }
    association :user
  end
end
