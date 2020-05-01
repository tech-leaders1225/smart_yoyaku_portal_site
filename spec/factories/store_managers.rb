FactoryBot.define do
  factory :store_manager do
    sequence(:email) { |n| "store_manager-#{n}@example.com" }
    sequence(:name) { |n| "store_manager#{n}" }
    password { "password" }

  end
end
