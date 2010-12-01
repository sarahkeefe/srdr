class OutcomeColumn < ActiveRecord::Base
	belongs_to :outcome
	attr_accessible :name, :description, :outcome_id, :subgroup_id, :timepoint_id
	#validates :name, :presence => true
	
end
