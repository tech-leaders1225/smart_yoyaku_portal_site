FactoryBot.define do
  factory :store do
    sequence(:store_name) { |n| "Store-#{n}" }
    sequence(:store_phonenumber) { |n| "0120-000-00#{n}" }

    after(:build) do |store|
      store.store_manager = create(:store_manager)
    end
  end
end
