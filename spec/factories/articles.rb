FactoryGirl.define do
  factory :article do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentences(10).join(" ") }
  end

  trait :free do
    free true
  end

  trait :premium do
    free false
  end
end
