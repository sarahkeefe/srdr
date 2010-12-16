class Arm < ActiveRecord::Base
	belongs_to :study
	has_many :population_characteristics
	validates :title, :presence => true
	
	def self.get_title(arm_id)
		arm = Arm.find(:first, arm_id, :select=>"title")
		return arm.title
	end
	
	
	def get_display_number(study_id)
	  current_max = Arm.maximum("display_number",:conditions => ["study_id = ?", study_id])
	  if (current_max.nil?)
	  	current_max = 0
	  end
		return current_max + 1
	end
	
	def shift_display_numbers(study_id)
		myNum = self.display_number
		high_things = Arm.find(:all, :conditions => ["study_id = ? AND display_number > ?", study_id, myNum])
		high_things.each { |thing|
		  tmpNum = thing.display_number
		  thing.display_number = tmpNum - 1
		  thing.save 
	  }
	end  

	def self.move_up_this(id)
		@this = Arm.find(id.to_i)
		if @this.display_number > 1
			new_num = @this.display_number - 1
			Arm.decrease_other(new_num)
			@this.display_number = new_num
			@this.save
		end
	end
	
	def self.decrease_other(num)
		@other = Arm.where(:display_number => num).first
		if !@other.nil?
			@other.display_number = @other.display_number + 1;
			@other.save
		end
	end
  
  
end
