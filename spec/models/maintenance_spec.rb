require 'rails_helper'

RSpec.describe Maintenance, type: :model do

   it { should belong_to(:vehicle) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:mainTask) }

end
