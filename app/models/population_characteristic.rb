class PopulationCharacteristic < ActiveRecord::Base

	def self.has_duplicates(category_title, subcategory, study_id)
			if subcategory.nil? || subcategory == ""
				@pop_char_check = PopulationCharacteristic.where("population_characteristics.study_id = ? AND population_characteristics.category_title = ?", study_id, category_title).all
					if @pop_char_check.length > 0
						return true
					else
						return false
					end
			else
				@sub_check = PopulationCharacteristic.where("population_characteristics.study_id = ? AND population_characteristics.category_title = ? AND population_characteristics.subcategory = ?", study_id, category_title, subcategory).all
				if @sub_check.length > 0
					return true
				else
					return false
				end
			end
		end
		
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
end
