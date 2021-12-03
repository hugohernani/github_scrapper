FactoryBot.define do
  factory :github_profile do
    user
    username { Faker::Internet.username }
    followers { Faker::Number.between(from: 1, to: 100) }
    following { Faker::Number.between(from: 1, to: 100) }
    stars { Faker::Number.between(from: 1, to: 100) }
    contributions { Faker::Number.between(from: 1, to: 10_000) }
    image_url { Faker::Avatar.image }
  end
end
