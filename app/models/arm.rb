class Arm < ActiveRecord::Base
	belongs_to :study
	has_many :population_characteristics
end
