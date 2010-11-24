class OutcomeColumn < ActiveRecord::Base
	belongs_to :outcome
	attr_accessible :name, :description
	validates :name, :presence => true
end
