FactoryBot.define do
  factory :groupschedule do
    day              { Faker::Number.between(from: 1, to: 7) }
    association :room
  end
end
