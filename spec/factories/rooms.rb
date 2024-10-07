FactoryBot.define do
  factory :room do
    room_name              { Faker::Name.name }
    contact                {Faker::Internet.url}
    association :creator, factory: :user 
     after(:build) do |room|
      room.image_rooms.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
