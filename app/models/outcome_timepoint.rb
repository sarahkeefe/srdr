class OutcomeTimepoint < ActiveRecord::Base
	belongs_to :outcome
	attr_accessible :number, :time_unit
	validates :number, :presence => true, :numericality => true
	validates :time_unit, :presence => true
end
