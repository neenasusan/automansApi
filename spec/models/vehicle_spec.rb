require 'rails_helper'

RSpec.describe Vehicle, type: :model do


it { should have_many(:maintenances).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:licenceNum) }
  it { should validate_presence_of(:vehicleType) }
  it { should validate_presence_of(:vehicleModel) }
  it { should validate_presence_of(:modelYear) }
  it { should validate_presence_of(:odoRead) }

end
