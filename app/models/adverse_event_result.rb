class AdverseEventResult < ActiveRecord::Base

		def self.get_data_point(ae_id, column_id)
			result = AdverseEventResult.where(:adverse_event_id => ae_id, :column_id => column_id).first
			if result.nil?
				return ""
			else
				return result.value
			end
		end
	
	# parse parameter string
	# formatted as: ae[X]_[Y]
	# X = adverse_event id
	# Y = adverse_event_column_id
	def self.save_data_points(params, study_id)
			for item in params
				# parse each parameter element
				if (item[0].starts_with? "ae")
					parts = item[0].to_s.split("_")		
					adverse_event_id = parts[0].from(2).to_i

					for elem in item[1]
						column_id = elem[0].to_i
						column_value = elem[1]
						existing = AdverseEventResult.where(:adverse_event_id => adverse_event_id, :column_id => column_id).first
						if !existing.nil?
							#column value exists, update value
							existing_result = AdverseEventResult.where(:adverse_event_id => adverse_event_id, :column_id => column_id).first
							existing_result.value = column_value
							existing_result.save
						else
							#column value does not exist, create new outcome result object
							new_result = AdverseEventResult.new
							new_result.adverse_event_id = adverse_event_id
							new_result.column_id = column_id
							new_result.value = column_value
							new_result.save
						end
					end
				end
			end
		end		


end
