FactoryBot.define do
  factory :income do
    name{ "name" }
    value { "10000" }
    description { "description" }
    start_time { "20220201" }
    association :user
  end
end
