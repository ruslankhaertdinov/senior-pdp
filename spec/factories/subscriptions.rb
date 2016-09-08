FactoryGirl.define do
  factory :subscription do
    user
    active_until { 1.week.from_now }
    association :author, factory: :user
    stripe_charge_id { Faker::Crypto.md5 }
  end
end
