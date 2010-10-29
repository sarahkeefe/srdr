class CreatePopulationCharacteristicDataPoints < ActiveRecord::Migration
  def self.up
    create_table :population_characteristic_data_points do |t|
      t.integer :attribute_id
      t.string :value
      t.integer :arm_id

      t.timestamps
    end
  end

  def self.down
    drop_table :population_characteristic_data_points
  end
end
