class OutcomeResult < ActiveRecord::Base

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

		def self.get_data_point_calc(arm_id, outcome_id, timepoint_id, subgroup_id)
			o_res = OutcomeResult.where(:outcome_id => outcome_id, :arm_id => arm_id, :subgroup_id => subgroup_id, :timepoint_id => timepoint_id).first
			arr = Hash.new
			if !o_res.nil?
				arr["nanalyzed"] = o_res.nanalyzed_is_calculated
				arr["measurereg"] = o_res.measurereg_is_calculated
				arr["measuredisp"] = o_res.measuredisp_is_calculated
				arr["pvalue"] = o_res.pvalue_is_calculated
			else
				arr["nanalyzed"] = ""
				arr["measurereg"] = ""
				arr["measuredisp"] = ""
				arr["pvalue"] = ""				
			end
			return arr
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
