FactoryBot.define do
  factory :variablecost do
    name{ "name" }
    value { "10000" }
    description { "description" }
    start_time { "20220201" }
    association :user
  end
end
