class OutcomeEnrolledNumber < ActiveRecord::Base
	belongs_to :outcome
	attr_accessible :arm_id, :outcome_id, :num_enrolled
end
