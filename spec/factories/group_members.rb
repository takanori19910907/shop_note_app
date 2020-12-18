FactoryBot.define do
  factory :group_member do
    activated { false }
    association :user
    association :group
  end
end
