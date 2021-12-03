FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    url { Faker::Internet.url }

    trait :with_github_profile do
      after(:create){ |user| create(:github_profile, user: user) }
    end
  end
end
