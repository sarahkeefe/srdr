class PopulationCharacteristicSubcategory < ActiveRecord::Base
	belongs_to :population_characteristic
	attr_accessible :subcategory, :units, :value, :population_characteristic_id
	validates :subcategory, :presence => true, :uniqueness => {:scope => :population_characteristic_id, :error_messages_for => :population_characteristic}
end
