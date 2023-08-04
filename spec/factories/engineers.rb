
FactoryBot.define do
  factory :engineer do
    email { Faker::Internet.email }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
    association :phase
  end
end
