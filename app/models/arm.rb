class Arm < ActiveRecord::Base
	belongs_to :study
	has_many :population_characteristics
	validates :title, :presence => true
	
	def self.get_title(arm_id)
		arm = Arm.find(:first, arm_id, :select=>"title")
		return arm.title
	end
end
