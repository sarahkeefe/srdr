class Outcome < ActiveRecord::Base
	has_many :outcome_analyses
	has_many :outcome_results
	has_many :outcome_timepoints
	has_many :outcome_enrolled_numbers
	belongs_to :study
	accepts_nested_attributes_for :outcome_timepoints, :allow_destroy => true
	accepts_nested_attributes_for :outcome_enrolled_numbers, :allow_destroy => true
	attr_accessible :outcome_type, :study_id, :title, :is_primary, :units, :outcome_timepoints_attributes, :description, :notes, :arm_id, :outcome_id, :num_enrolled
	
	
	def self.get_timepoints(outcome_id)
		@outcome_tps = OutcomeTimepoint.where(:outcome_id => outcome_id).all
		tp_array = []
		for i in @outcome_tps
			tp_array << i.number.to_s + " " + i.time_unit
		end
		tp_list = tp_array.join(', ')
		return tp_list 
	end

	def self.get_timepoints_array(outcome_id)
		@outcome_tps = OutcomeTimepoint.where(:outcome_id => outcome_id).all
		return @outcome_tps 
	end
	
	def self.getNumEnrolledByArm(outcome_id, arm_id)
		num = OutcomeEnrolledNumber.where(:arm_id => arm_id, :outcome_id => outcome_id).all
		if num.length > 0
			return num[0].num_enrolled
		else
			return nil
		end
	end
end
