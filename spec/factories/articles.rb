FactoryGirl.define do
  factory :article do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentences(10).join(" ") }
  end
end
