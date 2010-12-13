class PopulationCharacteristicDataPoint < ActiveRecord::Base

	def self.get_data_point(arm_id, cat, subcat, is_total)
		if subcat && !subcat.nil? && !subcat.id.nil?
			dp = PopulationCharacteristicDataPoint.where(:arm_id => arm_id, :attribute_id => cat.id, :subcategory_id => subcat.id, :is_total => is_total).first
		else
			dp = PopulationCharacteristicDataPoint.where(:arm_id => arm_id, :attribute_id => cat.id, :subcategory_id => "-1", :is_total => is_total).first
		end
		
		if dp.nil?
			return ""
		else
			return dp.value
		end
		
	end

	
	
	def self.save_data_point_info(study_id, params)
	select setval('population_characteristics_data_points_id_seq', (select max(id) + 1 from population_characteristics_data_points))
		@study_arms = Study.get_arms(study_id)
		@study_pop_chars = Study.get_attributes(study_id)
		for a in @study_arms
		print @study_pop_chars.inspect
			for p in @study_pop_chars
			@study_pop_chars_subcats = Study.get_attribute_subcategories(p.id)
				if !@study_pop_chars_subcats.nil? && @study_pop_chars_subcats.length > 0
					for s in @study_pop_chars_subcats
						if !params["arm" + a.id.to_s + "attribute"][p.id.to_s + "_" + s.id.to_s].nil?
							@existing = PopulationCharacteristicDataPoint.where(:arm_id => a.id, :attribute_id => p.id, :subcategory_id => s.id, :is_total => false).all
							if @existing.length > 0
								for i in @existing
									if i.value != params["arm" + a.id.to_s + "attribute"][p.id.to_s + "_" + s.id.to_s]
										i.value = params["arm" + a.id.to_s + "attribute"][p.id.to_s + "_" + s.id.to_s]
										i.save
									end
								end
							else						
								@population_characteristic_data_point = PopulationCharacteristicDataPoint.new(params[:population_characteristic_data_point])
								@population_characteristic_data_point.arm_id = a.id
								@population_characteristic_data_point.attribute_id = p.id
								@population_characteristic_data_point.subcategory_id = s.id
								@population_characteristic_data_point.value = params["arm" + a.id.to_s + "attribute"][p.id.to_s + "_" + s.id.to_s]
								@population_characteristic_data_point.is_total = false
								@population_characteristic_data_point.save
							end
						end
					end
				else
					if !params["arm" + a.id.to_s + "attribute"][p.id.to_s + "_-1"].nil?
						@existing = PopulationCharacteristicDataPoint.where(:arm_id => a.id, :attribute_id => p.id, :subcategory_id => "-1", :is_total => false).all
						if @existing.length > 0
							for i in @existing
								if i.value != params["arm" + a.id.to_s + "attribute"][p.id.to_s + "_-1"]
									i.value = params["arm" + a.id.to_s + "attribute"][p.id.to_s + "_-1"]
									i.save
								end
							end
						else
							@population_characteristic_data_point = PopulationCharacteristicDataPoint.new(params[:population_characteristic_data_point])
							@population_characteristic_data_point.arm_id = a.id
							@population_characteristic_data_point.attribute_id = p.id
							@population_characteristic_data_point.subcategory_id = -1
							@population_characteristic_data_point.value = params["arm" + a.id.to_s + "attribute"][p.id.to_s + "_-1"]
							@population_characteristic_data_point.is_total = false
							@population_characteristic_data_point.save
						end
					end				
				end
			end
		end	
	end
	
	def self.save_data_point_totals(study_id, params)
		@study_arms = Study.get_arms(study_id)
		@study_pop_chars = Study.get_attributes(study_id)	
		for p in @study_pop_chars	
			@study_pop_chars_subcats = Study.get_attribute_subcategories(p.id)
			if !@study_pop_chars_subcats.nil? && @study_pop_chars_subcats.length > 0
				for s in @study_pop_chars_subcats		
					if !params["attribute_total"][p.id.to_s + "_" + s.id.to_s].nil?
						@existing = PopulationCharacteristicDataPoint.where(:arm_id => -1, :attribute_id => p.id, :subcategory_id => s.id, :is_total => true).all
						if @existing.length > 0
							for i in @existing
								if i.value != params["attribute_total"][p.id.to_s + "_" + s.id.to_s]
									i.value = params["attribute_total"][p.id.to_s + "_" + s.id.to_s]
									i.save
								else
								end
							end
						else
							@population_characteristic_data_point = PopulationCharacteristicDataPoint.new(params[:population_characteristic_data_point])
							@population_characteristic_data_point.arm_id = -1
							@population_characteristic_data_point.attribute_id = p.id
							@population_characteristic_data_point.subcategory_id = s.id
							@population_characteristic_data_point.value = params["attribute_total"][p.id.to_s + "_" + s.id.to_s]
							@population_characteristic_data_point.is_total = true
							@population_characteristic_data_point.save
						end
					end
				end
			else
				if !params["attribute_total"][p.id.to_s + "_-1"].nil?
					@existing = PopulationCharacteristicDataPoint.where(:arm_id => -1, :attribute_id => p.id, :subcategory_id => -1, :is_total => true).all
					if @existing.length > 0
						for i in @existing
							if i.value != params["attribute_total"][p.id.to_s + "_-1"]
								i.value = params["attribute_total"][p.id.to_s + "_-1"]
								i.save
							else
							end
						end
					else
						@population_characteristic_data_point = PopulationCharacteristicDataPoint.new(params[:population_characteristic_data_point])
						@population_characteristic_data_point.arm_id = -1
						@population_characteristic_data_point.attribute_id = p.id
						@population_characteristic_data_point.subcategory_id = -1
						@population_characteristic_data_point.value = params["attribute_total"][p.id.to_s + "_-1"]
						@population_characteristic_data_point.is_total = true
						@population_characteristic_data_point.save
					end
				end			
			end
		end			
	end

end
