require 'securerandom'
FactoryBot.define do
  factory :room do
    room_name              { Faker::Name.name }
    contact                { Faker::Internet.url }
    summary                { Faker::Lorem.paragraph(sentence_count: 3) }
    password               { "1a" + SecureRandom.alphanumeric(4) }
    password_confirmation  { password }
    association :creator, factory: :user
    after(:build) do |room|
      room.image_rooms.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
