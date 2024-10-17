FactoryBot.define do
  factory :schedule_data do
    day              { Faker::Number.between(from: 1, to: 7) }
    association :room
    association :user
    association :game
    association :groupschedule

  end
end
