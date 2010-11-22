class AddSubcategoryIdToPopCharDatapoints < ActiveRecord::Migration
  def self.up
	add_column :population_characteristic_data_points, :subcategory_id, :integer
  end

  def self.down
	remove_column :population_characteristic_data_points, :subcategory_id  
  end
end
