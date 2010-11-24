class OutcomeSubgroup < ActiveRecord::Base
	belongs_to :outcome
	attr_accessible :title, :description
	validates :title, :presence => true
end
