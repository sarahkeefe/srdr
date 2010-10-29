class PopulationCharacteristicDataPoint < ActiveRecord::Base

	def self.get_data_point(arm_id, attribute_id, is_total)
		dp = PopulationCharacteristicDataPoint.where(:arm_id => arm_id, :attribute_id => attribute_id, :is_total => is_total).first
		return dp.value
	end


end
