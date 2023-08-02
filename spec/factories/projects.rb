# spec/factories/projects.rb
FactoryBot.define do
  factory :project do
    project_name { Faker::Lorem.word }
    association :assigned_manager, factory: :user
    association :lead, factory: :user
  end
end
