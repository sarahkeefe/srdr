class CreatePopulationCharacteristics < ActiveRecord::Migration
  def self.up
    create_table :population_characteristics do |t|
      t.integer :study_id
      t.integer :arm_id
      t.string :category_title
      t.string :subcategory
      t.string :units

      t.timestamps
    end
  end

  def self.down
    drop_table :population_characteristics
  end
end
