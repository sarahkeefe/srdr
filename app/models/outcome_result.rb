class OutcomeResult < ActiveRecord::Base

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
						field_name = "out#{outcome_id.to_s}_arm#{arm_id.to_s}_tp#{timepoint_id.to_s}_#{column_id.to_s}"
						column_value = check_for_footnotes(column_value,field_name,study_id)
						existing = OutcomeResult.where(:outcome_id => outcome_id, :arm_id => arm_id, :timepoint_id => timepoint_id, :outcome_column_id => column_id).first
						if !existing.nil?
							#column value exists, update value
							existing_result = OutcomeResult.where(:outcome_id => outcome_id, :arm_id => arm_id, :timepoint_id => timepoint_id,:outcome_column_id => column_id).first
							existing_result.value = column_value
							existing_result.is_calculated = params["out" + outcome_id.to_s + "_arm" + arm_id.to_s + "_tp" + timepoint_id.to_s + "_col" + column_id.to_s + "_calc"]
							existing_result.save
						else
							#column value does not exist, create new outcome result object
							new_result = OutcomeResult.new
							new_result.arm_id = arm_id
							new_result.outcome_id = outcome_id
							new_result.timepoint_id = timepoint_id
							new_result.outcome_column_id = column_id
							new_result.value = column_value
							new_result.is_calculated = params["out" + outcome_id.to_s + "_arm" + arm_id.to_s + "_tp" + timepoint_id.to_s + "_col" + column_id.to_s + "_calc"]
							new_result.save
						end
					end
				end
			end
		end
		# if footnotes exist, pull them out, return the value and save the 
		# footnote information to the junction table for outcome_results
    def self.check_for_footnotes(input,field_id,study_id)
    	retVal = input
      fid = field_id
      sid = study_id.to_i
      	
    	if input =~ /\s*\d+\s*\[\s*\d?.*\]/
    		
    		# first, separate the value from the footnotes
    		open_bracket = input =~ /\[/
    		data = input[0,open_bracket]
    		retVal = data.strip  # remove leading or trailing space
    		close_bracket = input =~ /\]/
    		
    		# gather the information between the brackets
    		fnotes = input[open_bracket+1, (close_bracket - open_bracket - 1)]
    		fnotes = fnotes.split(",")
    		
    		unless fnotes.empty?
    			# remove previous junction table information for this field
    			previous_notes = FootnoteField.where(:study_id=>sid, :field_id=>fid)
    	  	previous_notes.each do |pn|
    	  		pn.destroy
    	  	end
	    		
					# now, add the info to the footnote junction table    	  
    	  	fnotes.each do |fn|
	    			new_note = FootnoteField.new(:study_id=>sid,:field_id=>fid,:footnote_id=>fn.to_i)
	    		  new_note.save
	    		  if new_note.save
	    		  	#print "\n\n\n Footnote for #{fid} saved to junction successfully...\n\n\n"
	    		  else
	    		  	#print "\n\n\nSaving footnote to junction was unsuccessful for #{fid}"
	  		  	end
	    		end
	    	end
    	end
    	return retVal
    end		
    	
		def self.get_data_point(outcome_id, arm_id, timepoint_id, column_id)
			result = OutcomeResult.where(:outcome_id => outcome_id, :arm_id => arm_id, :timepoint_id => timepoint_id, :outcome_column_id => column_id).first
			if result.nil?
				return ""
			else
				return result.value
			end
		end
		
		def self.get_data_point_calc(outcome_id, arm_id, timepoint_id, column_id)
			result = OutcomeResult.where(:outcome_id => outcome_id, :arm_id => arm_id, :timepoint_id => timepoint_id, :outcome_column_id => column_id).first
			if result.nil?
				return nil
			else
				return result.is_calculated
			end		
		end
		
		def self.get_table_footnotes(outcome, timepoint, subgroup)
			@footnotes = OutcomeResultsNote.where(:outcome_id => outcome, :timepoint_id => timepoint, :subgroup_id => subgroup).first
			str = ""
			if !@footnotes.nil?
				str += @footnotes.notes.to_s
			end
			return str
		end

		# clear_table
		# take all parameters from the above form
		# delete all elements in OutcomeResults that match
		def self.clear_table(params)
			study_id = params[:study_id]
			@all_outcomes = Outcome.where(:study_id => study_id).all
			for outcome in @all_outcomes
				@to_be_deleted = OutcomeResult.where(:outcome_id => outcome.id).all
				for tbd in @to_be_deleted
					tbd.destroy
				end
			end
		end

		# return a list of field ids based on a list of outcomes, arms and timepoints
		# field ids are structure such as:
		# outA_armB_tpC_D
		# where A = outcome id
		# where B = arm id
		# where C = timepoint id
		# where D = column id
		def self.get_list_of_field_ids(outcome_ids, arm_ids, timepoints_arrays, column_ids)
			fields = []
			unless outcome_ids.empty?
				i = 0
				for ocid in outcome_ids
					outcome = "out#{ocid.to_s}_"
					unless arm_ids.empty?
						for armid in arm_ids
							arm = outcome + "arm#{armid.to_s}_"
							for tp in timepoints_arrays[i]	
								timepoint = arm + "tp#{tp.id.to_s}_"
								for colid in column_ids
									full_id = timepoint + "#{colid.to_s}"
									fields << full_id
								end
							end
						end
					end
					i += 1
				end
			end
			return fields
		end
end
