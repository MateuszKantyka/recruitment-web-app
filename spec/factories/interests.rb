FactoryBot.define do
  factory :interest do
    name 'Ruby'
    type 'work'
    association :user
  end
end
