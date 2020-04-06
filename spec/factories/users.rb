FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TestUser-#{n}" }
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { "password" } 
    sequence(:nickname) { |n| "test-#{n}" }
  end
end
