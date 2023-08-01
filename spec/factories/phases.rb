
FactoryBot.define do
  factory :phase do
    phase_type { Faker::Lorem.word }
    start_date { Faker::Date.forward(days: 30).strftime('%a, %d %b %Y') }
    due_date { Faker::Date.forward(days: 60).strftime('%a, %d %b %Y')}
    creation_date { Faker::Date.backward(days: 90).strftime('%a, %d %b %Y')}
    completed { false }
    completed_date { nil }
    association :lead
    association :assignee, factory: :user
  end
end
