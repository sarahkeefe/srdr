class AdverseEvent < ActiveRecord::Base
	#validates :title, :presence=> true, :length => { :minimum => 4}
	
	def self.get_adverse_events_by_arm(arm_id)
		return AdverseEvent.find(:all, :conditions => ["arm_id = ?", arm_id ])
	end
	
	def self.get_related_study_arms(study_id)
		return Arm.find(:all, :conditions => ["study_id = ?", study_id], :order => "display_number ASC")
	end

end
