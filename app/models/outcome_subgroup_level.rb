class OutcomeSubgroupLevel < ActiveRecord::Base
	belongs_to :outcome_subgroup
	attr_accessible :title, :description
	#validates :title, :presence => true, :uniqueness => {:scope => :outcome_subgroup_id, :error_messages_for => :outcome}	
end
