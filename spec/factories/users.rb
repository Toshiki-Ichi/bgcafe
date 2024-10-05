FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    career_id             { Faker::Number.between(from: 2, to: 6) } 
    likes                 { Faker::Lorem.sentence }
    weakness              { Faker::Lorem.sentence }
    sns                   { Faker::Internet.url }
    note                  { Faker::Lorem.paragraphs(number: 3).join(" ") }

  end
end
