class OutcomeTimepoint < ActiveRecord::Base
	belongs_to :outcome
	attr_accessible :number, :time_unit
	validates :number, :presence => true, :numericality => true
	validates :time_unit, :presence => true
	
	def self.get_title(id)
		@timepoint = OutcomeTimepoint.find(id)
		return @timepoint.number.to_s + " " + @timepoint.time_unit
	end
	
	def self.baseline_timepoint_exists(outcome_id)
		@exists = OutcomeTimepoint.where(:outcome_id => outcome_id, :number => 0, :time_unit => "baseline").first
		if @exists.nil? || @exists.length == 0
			return false
		else return true
		end
	end
	
end
