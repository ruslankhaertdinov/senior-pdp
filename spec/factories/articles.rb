FactoryGirl.define do
  factory :article do
    user
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
  end
end
