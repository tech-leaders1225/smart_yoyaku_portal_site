FactoryBot.define do
  factory :masseur do
    sequence(:masseur_name) { |n| "Masseur-#{n}" }
    sequence(:email) { |n| "masseur-#{n}@example.com" }
    password { "password" } 
  end
end
