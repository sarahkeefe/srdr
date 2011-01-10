class OutcomeComparison < ActiveRecord::Base

		# save_data_points
		# save data points based on parameters submitted to form
		# format is: outX_armY_tpZ_Q for values
		#     outX_armY_tpZ_colQ_calc for is_calculated
		#     X = outcome_id
		#     Y = arm_id
		#     Z = timepoint_id
		#     Q = column_id
		def self.save_data_points(params, study_id)
			for item in params
				# parse each parameter element
				if (item[0].starts_with? "out") && !(item[0].ends_with? "calc")
					parts = item[0].to_s.split("_")
					outcome_id = parts[0].from(3).to_i
					arm_id = parts[1].from(3).to_i
					timepoint_id = parts[2].from(2).to_i
					for elem in item[1]
						column_id = elem[0].to_i
						column_value = elem[1]
						existing = OutcomeComparison.where(:outcome_id => outcome_id, :arm_id => arm_id, :timepoint_id => timepoint_id, :outcome_comparison_column_id => column_id).first
						if !existing.nil?
							#column value exists, update value
							existing_result = OutcomeComparison.where(:outcome_id => outcome_id, :arm_id => arm_id, :timepoint_id => timepoint_id,:outcome_comparison_column_id => column_id).first
							existing_result.value = column_value
							existing_result.is_calculated = params["out" + outcome_id.to_s + "_arm" + arm_id.to_s + "_tp" + timepoint_id.to_s + "_col" + column_id.to_s + "_calc"]
							existing_result.save
						else
							#column value does not exist, create new outcome result object
							new_result = OutcomeComparison.new
							new_result.arm_id = arm_id
							new_result.outcome_id = outcome_id
							new_result.timepoint_id = timepoint_id
							new_result.outcome_comparison_column_id = column_id
							new_result.value = column_value
							new_result.is_calculated = params["out" + outcome_id.to_s + "_arm" + arm_id.to_s + "_tp" + timepoint_id.to_s + "_col" + column_id.to_s + "_calc"]
							new_result.save
						end
					end
				end
			end
		end
			
		def self.get_data_point(outcome_id, arm_id, timepoint_id, column_id)
			result = OutcomeComparison.where(:outcome_id => outcome_id, :arm_id => arm_id, :timepoint_id => timepoint_id, :outcome_comparison_column_id => column_id).first
			if result.nil?
				return ""
			else
				return result.value
			end
		end
		
		def self.get_data_point_calc(outcome_id, arm_id, timepoint_id, column_id)
			result = OutcomeComparison.where(:outcome_id => outcome_id, :arm_id => arm_id, :timepoint_id => timepoint_id, :outcome_comparison_column_id => column_id).first
			if result.nil?
				return nil
			else
				return result.is_calculated
			end		
		end

		# clear_table
		# take all parameters from the above form
		# delete all elements in OutcomeComparisons that match
		def self.clear_table(params)
			study_id = params[:study_id]
			@all_outcomes = Outcome.where(:study_id => study_id).all
			for outcome in @all_outcomes
				@to_be_deleted = OutcomeComparison.where(:outcome_id => outcome.id).all
				for tbd in @to_be_deleted
					tbd.destroy
				end
			end
		end


end
