# spec/factories/comments.rb
FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    commentable_type { 'Lead' }
    commentable_id { 38 }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
