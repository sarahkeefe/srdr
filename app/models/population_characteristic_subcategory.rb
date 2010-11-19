class PopulationCharacteristicSubcategory < ActiveRecord::Base

	belongs_to :population_characteristic
	attr_accessible :subcategory, :units, :value, :population_characteristic_id
end
