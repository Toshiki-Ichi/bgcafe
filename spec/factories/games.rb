FactoryBot.define do
  factory :game do
    game_name              { Faker::Name.name }
    rule                {Faker::Internet.url}
    association :user 
    association :room 

     after(:build) do |game|
      game.image_games.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
