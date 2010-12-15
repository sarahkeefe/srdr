class PopulationCharacteristic < ActiveRecord::Base
	belongs_to :study
	has_many :population_characteristic_subcategories, :dependent=>:destroy
	accepts_nested_attributes_for :population_characteristic_subcategories, :allow_destroy => true, :reject_if => :reject_condition
	# Check if there is a duplicate population characteristic category and subcategory in the list
	# (used in determining whether to create a new PopulationCharacteristic item )
	validates :category_title, :presence => true, :uniqueness => {:scope=>:study_id}
	#validates :units, :presence => true

		def get_display_number(study_id)
	  current_max = PopulationCharacteristic.maximum("display_number",:conditions => ["study_id = ?", study_id])
	  if (current_max.nil?)
	  	current_max = 0
	  end
		return current_max + 1
	end
	
	def shift_display_numbers(study_id)
		myNum = self.display_number
		high_things = PopulationCharacteristic.find(:all, :conditions => ["study_id = ? AND display_number > ?", study_id, myNum])
		high_things.each { |thing|
		  tmpNum = thing.display_number
		  thing.display_number = tmpNum - 1
		  thing.save 
	  }
	end  

	def self.move_up_this(id)
		@this = PopulationCharacteristic.find(id.to_i)
		if @this.display_number > 1
			new_num = @this.display_number - 1
			PopulationCharacteristic.decrease_other(new_num)
			@this.display_number = new_num
			@this.save
		end
	end
	
	def self.decrease_other(num)
		@other = PopulationCharacteristic.where(:display_number => num).first
		if !@other.nil?
			@other.display_number = @other.display_number + 1;
			@other.save
		end
	end
  
	
	
def reject_condition(attributed)
	reject = false
	if (attributed['subcategory'] == "" || attributed['subcategory'].blank?)
		reject = true
	end
	return reject
end
	
	# Get the number of categories that are the same
	# used in grouping attributes by category and subcategory
	def self.get_num_same_cats(list, pos)
		num_matching_category_titles = 0
		if list.length > 0
			while ((pos+1) < list.length) && (list[pos].category_title == list[(pos+1)].category_title)
				num_matching_category_titles = num_matching_category_titles + 1
				pos = pos + 1
			end
			num_matching_category_titles = num_matching_category_titles + 1
		end
		return num_matching_category_titles
	end
	
	# Group attributes by category and subcategory
	# used for table display in table.html.erb
	def self.create_list_of_lists(list)
		final_list = []
		pos  = 0
		if list.length > 0
			while pos < list.length 
				num_in_group = PopulationCharacteristic.get_num_same_cats(list, pos)
				if num_in_group == 0
					num_in_group = list.length + 1
				end
				new_sublist = []
				new_pos = pos + num_in_group
				if new_pos < list.length
					for i in pos..(new_pos - 1)
						new_sublist << list[i]
					end
				else
					for i in pos..(list.length - 1)
						new_sublist << list[i]
					end
				end
				pos = new_pos			
			final_list = final_list + [new_sublist]
		end
		return final_list
		else return nil
		end		
	end
	
	def self.get_category_ids_string(study_id)
		str = ""
		cat_list = PopulationCharacteristic.where(:study_id => study_id).all
		for i in cat_list
			@subcat_list = PopulationCharacteristicSubcategory.where(:population_characteristic_id => i.id).all
			str += i.id.to_s + ":"
			for j in @subcat_list
				str += j.id.to_s + "-"
			end
			str += " "
		end
		return str
	end
	
	def self.get_arm_ids_string(arm_list)
		str = ""
		for i in arm_list
			str += i.id.to_s + " "
		end
		return str
	end

	def self.get_subcategory_ids_string(subcat_list)
		str = ""
		for i in subcat_list
			str += subcat_list.id + " "
		end
		return str
	end	
end
