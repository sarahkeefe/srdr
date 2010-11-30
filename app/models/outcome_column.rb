class OutcomeColumn < ActiveRecord::Base
	belongs_to :outcome
	attr_accessible :name, :description, :outcome_id, :subgroup_id, :timepoint_id
	#validates :name, :presence => true
	
	def self.get_custom_columns(outcome_id, timepoint_id, subgroup_id)
		@columns = OutcomeColumn.where(:outcome_id => outcome_id, :timepoint_id => timepoint_id, :subgroup_id => subgroup_id).all
		return @columns
	end
end
