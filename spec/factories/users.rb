FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    url { Faker::Internet.url }
  end
end
