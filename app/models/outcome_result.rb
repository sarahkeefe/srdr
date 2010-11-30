class OutcomeResult < ActiveRecord::Base

		def self.clear_table(params)
			@study_arms = Arm.where(:study_id => params[:study_id]).all
			for a in @study_arms
				@to_be_deleted = OutcomeResult.where(:study_id => params[:study_id], :arm_id => a.id, :timepoint_id => params[:tpid], :subgroup_id => params[:sid], :outcome_id => params[:oid]).all
				for tbd in @to_be_deleted
					tbd.destroy
				end
			end
		end

		def self.get_selected_outcome_results(o_id, sub_id, tp_id)
			@selected_outcome_object_results = OutcomeResult.where(:subgroup_id => sub_id.to_i, :timepoint_id => tp_id.to_i, :outcome_id => o_id.to_i).first		
			if @selected_outcome_object_results.nil?
				@selected_outcome_object_results = OutcomeResult.new
			end
			return @selected_outcome_object_results
		end

		# Save results in outcome_results_table as new OutcomeResult objects. 
		# does not include timepoint/arm data.
		def self.save_general_results(study_id, a, outcome_id, timepoint_id, subgroup_id, params)
				@existing = self.where(:outcome_id => outcome_id, :study_id => study_id, :arm_id => a.id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id).all
				if @existing.length > 0
					for i in @existing
						i.n_analyzed = params["arm_nanalyzed"][a.id.to_s]
						i.measure_type = params["measure_type"]["measure_type"]					
						i. measure_value = params["arm_measurereg"][a.id.to_s].to_s
						i.measure_dispersion_type = params["measure_disp_type"]["measure_disp_type"]						
						i.measure_dispersion_value = params["arm_measuredisp"][a.id.to_s].to_s
						i.p_value = params["arm_pvalue"][a.id.to_s].to_s
						if params["arm" + a.id.to_s + "_nanalyzed_calculated"] == "t"
							i.nanalyzed_is_calculated = true
						else
							i.nanalyzed_is_calculated = false						
						end
						if params["arm" + a.id.to_s + "_measurereg_calculated"] == "t"
							i.measurereg_is_calculated = true
						else
							i.measurereg_is_calculated = false						
						end	
						if params["arm" + a.id.to_s + "_measuredisp_calculated"] == "t"
							i.measuredisp_is_calculated = true
						else
							i.measuredisp_is_calculated = false						
						end	
						if params["arm" + a.id.to_s + "_pvalue_calculated"] == "t"
							i.pvalue_is_calculated = true
						else
							i.pvalue_is_calculated = false						
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
					@outcome_result_new.n_analyzed = params["arm_nanalyzed"][a.id.to_s]
					@outcome_result_new.measure_type = params["measure_type"]["measure_type"]			
					@outcome_result_new.measure_value = params["arm_measurereg"][a.id.to_s]
					@outcome_result_new.measure_dispersion_type = params["measure_disp_type"]["measure_disp_type"]
					@outcome_result_new.measure_dispersion_type = ""						
					@outcome_result_new.measure_dispersion_value = params["arm_measuredisp"][a.id.to_s]
					@outcome_result_new.p_value =  params["arm_pvalue"][a.id.to_s]
						if params["arm" + a.id.to_s + "_nanalyzed_calculated"] == "t"
							@outcome_result_new.nanalyzed_is_calculated = true
						else
							@outcome_result_new.nanalyzed_is_calculated = false						
						end
						if params["arm" + a.id.to_s + "_measurereg_calculated"] == "t"
							@outcome_result_new.measurereg_is_calculated = true
						else
							@outcome_result_new.measurereg_is_calculated = false						
						end	
						if params["arm" + a.id.to_s + "_measuredisp_calculated"] == "t"
							@outcome_result_new.measuredisp_is_calculated = true
						else
							@outcome_result_new.measuredisp_is_calculated = false						
						end	
						if params["arm" + a.id.to_s + "_pvalue_calculated"] == "t"
							@outcome_result_new.pvalue_is_calculated = true
						else
							@outcome_result_new.pvalue_is_calculated = false						
						end							
					@outcome_result_new.save
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
			if !o_res.nil?
				return o_res.value
			else
				return ""
			end
		end
		
		def self.get_data_point_calc(arm_id, outcome_id, timepoint_id, subgroup_id)
			o_res = OutcomeResult.where(:outcome_id => outcome_id, :arm_id => arm_id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id).first
			arr = Hash.new
			if !o_res.nil?
				arr["nanalyzed"] = (o_res.nanalyzed_is_calculated.to_s == 't' || o_res.nanalyzed_is_calculated.to_s == 'f') ? o_res.nanalyzed_is_calculated : "f"
				arr["measurereg"] = (o_res.measurereg_is_calculated.to_s == 't' || o_res.measurereg_is_calculated.to_s == 'f') ? o_res.measurereg_is_calculated : "f"
				arr["measuredisp"] = (o_res.measuredisp_is_calculated.to_s == 't' || o_res.measuredisp_is_calculated.to_s == 'f' ) ? o_res.measuredisp_is_calculated : "f"
				arr["pvalue"] = (o_res.pvalue_is_calculated.to_s == 't' || o_res.pvalue_is_calculated.to_s == 'f' ) ? o_res.pvalue_is_calculated : "f"
			else
				arr["nanalyzed"] = ""
				arr["measurereg"] = ""
				arr["measuredisp"] = ""
				arr["pvalue"] = ""				
			end
			return arr
		end
		
		def self.get_custom_col_data_point_calc(arm_id, outcome_id, timepoint_id, subgroup_id, col_id)
			o_res = OutcomeColumnValue.where(:outcome_id => outcome_id, :arm_id => arm_id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id, :column_id => col_id).first
			if !o_res.nil?
				return o_res.is_calculated
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
		

		def self.get_outcomes_for_dropdown
			#@outcomes = Outcome.find(:all, :conditions => {:study_id => session[:study_id]})		
				arr = []
			if !@outcomes.nil?
				for i in @outcomes

				end
			end
			return arr
		end

		
end
