FactoryBot.define do
  factory :vehicle do
    licenceNum { Faker::Lorem.word }
    vehicleType { Faker::Lorem.word }
    vehicleModel { Faker::Lorem.word }
    modelYear { Faker::Number.number(10) }
    odoRead { Faker::Number.number(10) }

  end
end