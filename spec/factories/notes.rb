FactoryBot.define do
  factory :note do
    sequence(:content) { |n| "shoppnig_note#{n}" }
    association :user
  end
end
