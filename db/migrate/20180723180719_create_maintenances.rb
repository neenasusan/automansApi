class CreateMaintenances < ActiveRecord::Migration[5.2]
  def change
    create_table :maintenances do |t|
      t.string :mainTask
      t.boolean :done
      t.string :date
      t.string :price
      t.references :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
