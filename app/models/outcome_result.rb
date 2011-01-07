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

		# if footnotes exist, pull them out, return the value and save the 
		# footnote information to the junction table for outcome_results
    def self.check_for_footnotes(input,result_inputs,field_name)
    	retVal = input
      	
    	if input =~ /\s*\d+\s*\[\s*\d?.*\]/
    		
    		# first, separate the value from the footnotes
    		open_bracket = input =~ /\[/
    		data = input[0,open_bracket]
    		retVal = data.strip  # remove leading or trailing space
    	  
    		# now, add the footnote information to a junction table
    		close_bracket = input =~ /\]/
    		
    		# gather the information between the brackets
    		fnotes = input[open_bracket+1, (close_bracket - open_bracket - 1)]
    		fnotes = fnotes.split(",")
    		unless fnotes.empty?
    			# remove previous junction table information for this field
    			previous_notes = FootnoteField.where(:study_id=>result_inputs[0], :outcome_id=>result_inputs[1],
    																	 :subgroup_id=>result_inputs[2], :timepoint_id=>result_inputs[3],
    																	 :field_name=>field_name)
    	  	previous_notes.each do |pn|
    	  		pn.destroy
    	  	end
	    		
					# now, add the info to the footnote junction table    	  
    	  	fnotes.each do |fn|
	    			new_note = FootnoteField.new(:study_id=>result_inputs[0], :outcome_id=>result_inputs[1],
	    													 :subgroup_id=>result_inputs[2], :timepoint_id=>result_inputs[3],
	    													 :footnote_number=>Integer(fn), :field_name=>field_name.to_s)
	    		  new_note.save
	    		  #if new_note.save
	    		  	#print "\n\n\n Footnote for #{field_name} saved to junction successfully...\n\n\n"
	    		  #else
	    		  	#print "\n\n\nSaving footnote to junction was unsuccessful for #{field_name}"
	  		  	#end
	    		end
	    	end
    	end
    	return retVal
    end

		
end
