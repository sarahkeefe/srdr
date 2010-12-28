class RemovePopulationCharacteristicsTables < ActiveRecord::Migration
  def self.up
	drop_table :population_characteristic_data_points if self.table_exists?("population_characteristic_data_points")  
	drop_table :population_characteristic_subcategories if self.table_exists?("population_characteristic_subcategories")  
	drop_table :population_characteristics if self.table_exists?("population_characteristics")  
	drop_table :forms if self.table_exists?("forms")  
	drop_table :study_baseline_characteristic_fields if self.table_exists?("study_baseline_characteristic_fields")  
	drop_table :outcome_subgroup_levels if self.table_exists?("outcome_subgroup_levels")  
	end

  def self.down
  end
  
  def self.table_exists?(name)
    ActiveRecord::Base.connection.tables.include?(name)
  end
 
end
