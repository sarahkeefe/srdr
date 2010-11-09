class OutcomeTimepoint < ActiveRecord::Base
	belongs_to :outcome
	attr_accessible :number, :time_unit
end
