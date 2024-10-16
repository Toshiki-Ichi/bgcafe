FactoryBot.define do
  factory :game do
    game_name { Faker::Name.name }
    rule { Faker::Internet.url }
    capacity_id { Faker::Number.between(from: 1, to: 4) }
    require_time_id { Faker::Number.between(from: 2, to: 5) }

    association :user
    association :room

    after(:build) do |game|
      game.image_games.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
