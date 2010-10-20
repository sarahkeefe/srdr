class Study < ActiveRecord::Base
	belongs_to :project
	has_many :arms
	#has_many :outcome_analyses, through => :outcomes
	#has_many :outcome_results, through => :outcomes
	#has_many :outcome_timepoints, through => :outcomes
	#has_many :outcome_enrolled_numbers, through => :outcomes
	has_many :outcomes
	has_many :key_questions
	#has_many :population_characteristics, through => :arms
	#has_many :adverse_event_arms, through => :adverse_event
	has_many :adverse_events
	has_many :quality_aspects
	has_one :quality_rating
	has_many :publications
end
