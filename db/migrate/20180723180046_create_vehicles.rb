class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :licenceNum
      t.string :vehicleType
      t.string :vehicleModel
      t.string :modelYear
      t.string :odoRead

      t.timestamps
    end
  end
end
