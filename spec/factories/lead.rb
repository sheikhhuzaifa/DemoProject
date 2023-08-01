
FactoryBot.define do
  factory :lead do
    project_name { Faker::Lorem.words(number: 3).join(' ') }
    client_name { Faker::Name.name }
    client_address { Faker::Address.full_address }
    client_email { Faker::Internet.email }
    client_contact { Faker::PhoneNumber.phone_number.gsub(/\D/, '') }
    platform_used { Faker::Lorem.word }
    test_type { Faker::Lorem.word }
    association :user, factory: :user
    sale { false }
    sale_date { nil }
  end
end
