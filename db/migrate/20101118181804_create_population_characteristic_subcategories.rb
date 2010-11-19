class CreatePopulationCharacteristicSubcategories < ActiveRecord::Migration
  def self.up
    create_table :population_characteristic_subcategories do |t|
      t.string :subcategory
      t.string :units
      t.integer :population_characteristic_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :population_characteristic_subcategories
  end
end
