class OutcomeResult < ActiveRecord::Base

		# Save results in outcome_results_table as new OutcomeResult objects. 
		# does not include timepoint/arm data.
		def self.save_general_results(study_id, a, outcome_id, params)
				@existing = self.where(:outcome_id => outcome_id, :study_id => study_id, :arm_id => a.id).all
				if @existing.length > 0
					for i in @existing
						i.n_analyzed = params["arm_nanalyzed"][a.id.to_s]
						i.measure_type = params["measure_type"]["measure_type"]					
						i. measure_value = params["arm_measurereg"][a.id.to_s].to_s
						i.measure_dispersion_type = params["measure_disp_type"]["measure_type"]						
						i.measure_dispersion_value = params["arm_measuredisp"][a.id.to_s].to_s	
						i.p_value = params["arm_pvalue"][a.id.to_s].to_s			
						i.save
					end
				else
					@outcome_result_new = OutcomeResult.new(params[:outcome_result])
					@outcome_result_new.arm_id = a.id
					@outcome_result_new.study_id = study_id
					@outcome_result_new.outcome_id = outcome_id
					@outcome_result_new.n_analyzed = params["arm_nanalyzed"][a.id.to_s]
					@outcome_result_new.measure_type = params["measure_type"]["measure_type"]			
					@outcome_result_new.measure_value = params["arm_measurereg"][a.id.to_s]
					@outcome_result_new.measure_dispersion_type = params["measure_disp_type"]["measure_type"]
					@outcome_result_new.measure_dispersion_type = ""						
					@outcome_result_new.measure_dispersion_value = params["arm_measuredisp"][a.id.to_s]
					@outcome_result_new.p_value =  params["arm_pvalue"][a.id.to_s]
					@outcome_result_new.save
				end
		end

		# Save timepoint results based on arm in the outcome_timepoint_results table.
		def self.save_timepoint_results(outcome_id, study_id, a, tp, params)
			@existing = OutcomeTimepointResult.where(:outcome_id => outcome_id, :study_id => study_id, :arm_id => a.id, :timepoint_id => tp.id).all
				if @existing.length > 0
					for i in @existing
						i.value = params["arm" + a.id.to_s + "timepoint"][tp.id.to_s]
						i.save
					end
				else
					@outcome_tp_result_new = OutcomeTimepointResult.new
					@outcome_tp_result_new.arm_id = a.id
					@outcome_tp_result_new.study_id = study_id
					@outcome_tp_result_new.outcome_id = outcome_id				
					@outcome_tp_result_new.timepoint_id = tp.id	
					@outcome_tp_result_new.value = params["arm" + a.id.to_s + "timepoint"][tp.id.to_s]
					@outcome_tp_result_new.save
				end
		end
		
		def self.get_data_point(arm_id, outcome_id)
			o_res = OutcomeResult.where(:outcome_id => outcome_id, :arm_id => arm_id).first
			arr = Hash.new
			arr["nanalyzed"] = o_res.n_analyzed
			arr["measurereg"] = o_res.measure_value
			arr["measuredisp"] = o_res.measure_dispersion_value
			arr["pvalue"] = o_res.p_value
			return arr
		end
		
		def self.get_timepoint_data_point(arm_id, outcome_id, tp_id)
			o_res = OutcomeTimepointResult.where(:outcome_id => outcome_id, :arm_id => arm_id, :timepoint_id => tp_id).first
			return o_res.value		
		end
		
		def self.get_measure_types(outcome_id)
			o_res = OutcomeResult.where(:outcome_id => outcome_id).first
			arr = Hash.new
			arr["measure_type"] = o_res.measure_type
			arr["measure_dispersion_type"] = o_res.measure_dispersion_type
			return arr
		end
		
end
