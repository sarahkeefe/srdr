class OutcomeResult < ActiveRecord::Base

		def self.get_existing_outcome_combos(study_id)
			@results = OutcomeResult.select('DISTINCT outcome_id, subgroup_id, timepoint_id').where('study_id = ?', study_id)
			final = []
			group = Hash.new
			for r in @results
				if  !r.outcome_id.nil? && !r.timepoint_id.nil? && !r.subgroup_id.nil? && r.outcome_id != 0 && r.subgroup_id != 0 && r.timepoint_id != 0
					group["outcome"] = Outcome.get_title(r.outcome_id)
					group["outcome_id"] = r.outcome_id.to_s
					group["subgroup"] = OutcomeSubgroup.get_title(r.subgroup_id)
					group["subgroup_id"] = r.subgroup_id.to_s
					group["timepoint"] = OutcomeTimepoint.get_title(r.timepoint_id)
					group["timepoint_id"] = r.timepoint_id.to_s
					final << group
					group = Hash.new
				end
			end
			return final
		end

		def self.get_table_footnotes(outcome, timepoint, subgroup)
			@footnotes = OutcomeResultsNote.where(:outcome_id => outcome, :timepoint_id => timepoint, :subgroup_id => subgroup).first
			str = ""
			if !@footnotes.nil?
				str += @footnotes.notes.to_s
			end
			return str
		end

		def self.clear_table(params)
			@study_arms = Arm.where(:study_id => params[:study_id]).all
			for a in @study_arms
				@to_be_deleted = OutcomeResult.where(:study_id => params[:study_id], :arm_id => a.id, :timepoint_id => params[:timepoint_id], :subgroup_id => params[:subgroup_id], :outcome_id => params[:outcome_id]).all

				for tbd in @to_be_deleted
					tbd.destroy
				end
			end
			@custom_cols = OutcomeColumn.where(:timepoint_id => params[:timepoint_id], :subgroup_id => params[:subgroup_id], :outcome_id => params[:outcome_id]).all
			for col in @custom_cols
				col.destroy
			end
		end

		def self.get_selected_outcome_results(o_id, sub_id, tp_id)
			@selected_outcome_object_results = OutcomeResult.where(:subgroup_id => sub_id, :timepoint_id => tp_id, :outcome_id => o_id).first		
			if @selected_outcome_object_results.nil?
				@selected_outcome_object_results = OutcomeResult.new
			end
			return @selected_outcome_object_results
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
		# Save results in outcome_results_table as new OutcomeResult objects. 
		def self.save_general_results(study_id, a, outcome_id, timepoint_id, subgroup_id, params)
				@existing = self.where(:outcome_id => outcome_id, :study_id => study_id, :arm_id => a.id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id).all
				info_array = [study_id,outcome_id,subgroup_id,timepoint_id];
				if @existing.length > 0
					for i in @existing
						i.n_analyzed = check_for_footnotes(params["arm_nanalyzed"][a.id.to_s],info_array,"arm_nanalyzed_"+a.id.to_s)
						i.measure_type = params["measure_type"]["measure_type"]					
						i. measure_value = check_for_footnotes(params["arm_measurereg"][a.id.to_s].to_s,info_array,"arm_measurereg_"+a.id.to_s)
						i.measure_dispersion_type = params["measure_disp_type"]["measure_disp_type"]						
						i.measure_dispersion_value = check_for_footnotes(params["arm_measuredisp"][a.id.to_s].to_s,info_array,"arm_measuredisp_"+a.id.to_s)
						i.p_value = check_for_footnotes(params["arm_pvalue"][a.id.to_s].to_s,info_array,"arm_pvalue_"+a.id.to_s)
						if params["arm" + a.id.to_s + "_nanalyzed_calculated"].nil? || params["arm" + a.id.to_s + "_nanalyzed_calculated"].to_s == ""|| params["arm" + a.id.to_s + "_nanalyzed_calculated"].to_s == "f"
							i.nanalyzed_is_calculated = false
						else
							i.nanalyzed_is_calculated = true						
						end
						if params["arm" + a.id.to_s + "_measurereg_calculated"].nil? || params["arm" + a.id.to_s + "_measurereg_calculated"].to_s == ""|| params["arm" + a.id.to_s + "_measurereg_calculated"].to_s == "f"
							i.measurereg_is_calculated = false
						else
							i.measurereg_is_calculated = true						
						end	
						if params["arm" + a.id.to_s + "_measuredisp_calculated"].nil? || params["arm" + a.id.to_s + "_measuredisp_calculated"].to_s == ""|| params["arm" + a.id.to_s + "_measuredisp_calculated"].to_s == "f"
							i.measuredisp_is_calculated = false
						else
							i.measuredisp_is_calculated = true						
						end	
						if params["arm" + a.id.to_s + "_pvalue_calculated"].nil? || params["arm" + a.id.to_s + "_pvalue_calculated"].to_s == "" || params["arm" + a.id.to_s + "_pvalue_calculated"].to_s == "f"
							i.pvalue_is_calculated = false
						else
							i.pvalue_is_calculated = true						
						end							
						i.save
					end
				else
					@outcome_result_new = OutcomeResult.new(params[:outcome_result])
					@outcome_result_new.arm_id = a.id
					@outcome_result_new.study_id = study_id
					@outcome_result_new.outcome_id = outcome_id
					@outcome_result_new.timepoint_id = timepoint_id
					@outcome_result_new.subgroup_id = subgroup_id
					@outcome_result_new.n_analyzed = check_for_footnotes(params["arm_nanalyzed"][a.id.to_s],info_array,"arm_nanalyzed_"+a.id.to_s)
					@outcome_result_new.measure_type = params["measure_type"]["measure_type"]			
					@outcome_result_new.measure_value = check_for_footnotes(params["arm_measurereg"][a.id.to_s],info_array,"arm_measurereg_"+a.id.to_s)
					@outcome_result_new.measure_dispersion_type = params["measure_disp_type"]["measure_disp_type"]
					#@outcome_result_new.measure_dispersion_type = ""						
					@outcome_result_new.measure_dispersion_value = check_for_footnotes(params["arm_measuredisp"][a.id.to_s],info_array,"arm_measuredisp_"+a.id.to_s)
					@outcome_result_new.p_value =  check_for_footnotes(params["arm_pvalue"][a.id.to_s],info_array,"arm_pvalue_"+a.id.to_s)
						if params["arm" + a.id.to_s + "_nanalyzed_calculated"].nil? || params["arm" + a.id.to_s + "_nanalyzed_calculated"].to_s == "" || params["arm" + a.id.to_s + "_nanalyzed_calculated"].to_s == "f"
							@outcome_result_new.nanalyzed_is_calculated = false
						else
							@outcome_result_new.nanalyzed_is_calculated = true						
						end
						if params["arm" + a.id.to_s + "_measurereg_calculated"].nil? || params["arm" + a.id.to_s + "_measurereg_calculated"].to_s == "" || params["arm" + a.id.to_s + "_measurereg_calculated"].to_s == "f"
							@outcome_result_new.measurereg_is_calculated = false
						else
							@outcome_result_new.measurereg_is_calculated = true						
						end	
						if params["arm" + a.id.to_s + "_measuredisp_calculated"].nil? || params["arm" + a.id.to_s + "_measuredisp_calculated"].to_s == "" || params["arm" + a.id.to_s + "_measuredisp_calculated"].to_s == "f"
							@outcome_result_new.measuredisp_is_calculated = false
						else
							@outcome_result_new.measuredisp_is_calculated = true						
						end	
						if params["arm" + a.id.to_s + "_pvalue_calculated"].nil? || params["arm" + a.id.to_s + "_pvalue_calculated"].to_s == "" || params["arm" + a.id.to_s + "_pvalue_calculated"].to_s == "f"
							@outcome_result_new.pvalue_is_calculated = false
						else
							@outcome_result_new.pvalue_is_calculated = true						
						end							
					@outcome_result_new.save
				end
		end
		
		# Save results in custom columns as new OutcomeColumnValues
		def self.save_custom_results(study_id, a, outcome_id, timepoint_id, subgroup_id, column_id, params)
			@existing = OutcomeColumnValue.where(:outcome_id => outcome_id, :arm_id => a.id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id, :column_id => column_id).all
				if @existing.length > 0
					for i in @existing
						i.value = params["arm_custom" + column_id.to_s][a.id.to_s]
						if params["arm_custom" + a.id.to_s + "_custom" + column_id.to_s + "_calculated"]
							i.is_calculated = true
						else
							i.is_calculated = false
						end
						i.save
					end
				else
					@col_val_new = OutcomeColumnValue.new
					@col_val_new.arm_id = a.id
					@col_val_new.column_id = column_id
					@col_val_new.outcome_id = outcome_id
					@col_val_new.subgroup_id = subgroup_id
					@col_val_new.timepoint_id = timepoint_id
					@col_val_new.value = params["arm_custom" + column_id.to_s][a.id.to_s]
					if params["arm" + a.id.to_s + "_custom" + column_id.to_s + "_calculated"].to_s.eql? "t"
						@col_val_new.is_calculated = true
					else
						@col_val_new.is_calculated = false
					end
					@col_val_new.save
				end
		end
		
		def self.get_data_point(arm_id, outcome_id, timepoint_id, subgroup_id)
			o_res = OutcomeResult.where(:outcome_id => outcome_id, :arm_id => arm_id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id).first
			arr = Hash.new
			if !o_res.nil?
				arr["nanalyzed"] = o_res.n_analyzed
				arr["measurereg"] = o_res.measure_value
				arr["measuredisp"] = o_res.measure_dispersion_value
				arr["pvalue"] = o_res.p_value
			else
				arr["nanalyzed"] = ""
				arr["measurereg"] = ""
				arr["measuredisp"] = ""
				arr["pvalue"] = ""				
			end
			return arr
		end

	 def self.get_custom_col_data_point(arm_id, outcome_id, timepoint_id, subgroup_id, col_id)
			o_res = OutcomeColumnValue.where(:outcome_id => outcome_id, :arm_id => arm_id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id, :column_id => col_id).first
			return o_res.nil? ? nil : o_res.value
		end
		
		def self.get_data_point_calc(arm_id, outcome_id, timepoint_id, subgroup_id)
			o_res = OutcomeResult.where(:outcome_id => outcome_id, :arm_id => arm_id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id).first
			arr = Hash.new
			if !o_res.nil?
				arr["nanalyzed"] = (o_res.nanalyzed_is_calculated == true) ? true : false
				arr["measurereg"] = (o_res.measurereg_is_calculated == true)  ? true : false
				arr["measuredisp"] = (o_res.measuredisp_is_calculated == true)  ? true : false
				arr["pvalue"] = (o_res.pvalue_is_calculated == true) ? true : false
			else
				arr["nanalyzed"] = false
				arr["measurereg"] = false
				arr["measuredisp"] = false
				arr["pvalue"] = false				
			end
			return arr
		end
		
		def self.get_custom_col_data_point_calc(arm_id, outcome_id, timepoint_id, subgroup_id, col_id)
			o_res = OutcomeColumnValue.where(:outcome_id => outcome_id, :arm_id => arm_id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id, :column_id => col_id).first
			if !o_res.nil?
				return o_res.is_calculated.to_s == 't' ? true : false
			else
				return false		
			end
		end		

		def self.get_measure_types(outcome_id, timepoint_id, subgroup_id)
			o_res = OutcomeResult.where(:outcome_id => outcome_id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id).first
			if !o_res.nil?
				arr = Hash.new
				arr["measure_type"] = o_res.measure_type
				arr["measure_dispersion_type"] = o_res.measure_dispersion_type
				return arr
			else
				arr = Hash.new
				arr["measure_type"] = ""
				arr["measure_dispersion_type"] = ""
				return arr
			end
		end
		

# Return the ids for selected subgroup and timepoint in outcomedata or
  # outcomeanalysis pages. 
  # Params: arrays of subgroups and timepoints
  # Returns: an array containing subgroup id and timepoint id
  def self.get_selected_sg_and_tp(subgroups, timepoints)
  	print "GETTING THE SELECTIONS NOW -----------------\n"
  	selected_subgroup = 0
    selected_timepoint = 0
    retVal = Array.new
    unless subgroups.empty?
    	selected_subgroup = subgroups[0].id
    end
    unless timepoints.empty?
    	selected_timepoint = timepoints[0].id
    end
    retVal = [selected_subgroup, selected_timepoint]
    print "RETVAL IS: " + selected_subgroup.to_s + ", " + selected_timepoint.to_s + "._________________\n"
    return retVal
  end

		
end
