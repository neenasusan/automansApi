class Maintenance < ApplicationRecord
  belongs_to :vehicle

  validates_presence_of :mainTask
end
