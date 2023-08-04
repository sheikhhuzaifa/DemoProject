FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    firstname { Faker::Name.first_name }
    username { Faker::Internet.unique.username }
    lastname { Faker::Name.last_name }
    super_admin { false }
    confirmed_at { Time.current }
  end
end
