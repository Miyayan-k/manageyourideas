FactoryBot.define do
  factory :idea_category do
    category_name { Faker::Lorem.word }
    body          { Faker::Lorem.sentence}
  end
end