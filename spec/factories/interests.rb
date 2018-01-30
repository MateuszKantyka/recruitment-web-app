FactoryBot.define do
  factory :interest do
    name 'Ruby'
    type 'Work'
    association :user
  end
end
