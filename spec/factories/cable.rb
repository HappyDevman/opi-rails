FactoryBot.define do
  factory :cable do
    association :device
    cable_id { rand(100) }
  end
end
