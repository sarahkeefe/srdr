class OutcomeColumn < ActiveRecord::Base
	belongs_to :outcome
	has_many :outcome_column_values
	attr_accessible :name, :description, :outcome_id, :subgroup_id, :timepoint_id
	#validates :name, :presence => true
	
end
