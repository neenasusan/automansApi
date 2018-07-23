FactoryBot.define do
  factory :maintenance do
    mainTask { Faker::StarWars.character }
    done false
    vehicle_id nil
  end
end