class Vehicle < ApplicationRecord

	has_many :maintenances, dependent: :destroy

  # validations
  validates_presence_of :licenceNum, :vehicleType, :vehicleModel, :modelYear, :odoRead
end
