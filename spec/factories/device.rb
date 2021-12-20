FactoryBot.define do
  factory :device do
    device_id { rand(100) }
    battery_level { rand(100) }
    published_at { Time.zone.now }
  end
end
