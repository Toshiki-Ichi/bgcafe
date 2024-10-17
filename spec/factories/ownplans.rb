FactoryBot.define do
  factory :ownplan do
    day1              { Faker::Number.between(from: 1, to: 9).to_s }
    day2              { Faker::Number.between(from: 1, to: 9).to_s }
    day3              { Faker::Number.between(from: 1, to: 9).to_s }
    day4              { Faker::Number.between(from: 1, to: 9).to_s }
    day5              { Faker::Number.between(from: 1, to: 9).to_s }
    day6              { Faker::Number.between(from: 1, to: 9).to_s }
    day7              { Faker::Number.between(from: 1, to: 9).to_s }
    frequency_id      { Faker::Number.between(from: 1, to: 6) }

    association :user
    association :room
  end
end
