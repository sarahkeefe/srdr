class AddNotesToPopulationCharacteristics < ActiveRecord::Migration
  def self.up
	add_column :population_characteristics, :notes, :text
  end

  def self.down
	remove_column :population_characteristics, :notes, :text
  end
end
