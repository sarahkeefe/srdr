class Outcome < ActiveRecord::Base
	has_many :outcome_analyses
	has_many :outcome_results
	has_many :outcome_timepoints
	has_many :outcome_enrolled_numbers
	belongs_to :study
end
