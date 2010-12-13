class QualityAspect < ActiveRecord::Base
	#validates :dimension, :presence => true, :length => { :minimum => 4}
	
		def get_display_number(study_id)
	  current_max = QualityAspect.maximum("display_number",:conditions => ["study_id = ?", study_id])
	  if (current_max.nil?)
	  	current_max = 0
	  end
		return current_max + 1
	end
	
	def shift_display_numbers(study_id)
		myNum = self.display_number
		high_things = QualityAspect.find(:all, :conditions => ["study_id = ? AND display_number > ?", study_id, myNum])
		high_things.each { |thing|
		  tmpNum = thing.display_number
		  thing.display_number = tmpNum - 1
		  thing.save 
	  }
	end  	
	
end
