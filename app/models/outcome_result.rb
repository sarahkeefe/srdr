class OutcomeResult < ActiveRecord::Base

	def self.compare_and_update_result_nanalyzed(item, nanalyzed)
		if item.n_analyzed != nanalyzed
			item.n_analyzed = nanalyzed
			item.save
		else
		end
	end

	def self.compare_and_update_result_measuretype(item, measuretype)
		if item.measure_type != measuretype
			item.measure_type = measuretype
			item.save
		else
		end
	end	

	def self.compare_and_update_result_measurevalue(item, measurevalue)
		if item.measure_value != measurevalue
			item.measure_value = measurevalue
			item.save
		else
		end
	end	

	def self.compare_and_update_result_measuredisptype(item, measuredisptype)
		if item.measure_dispersion_type != measuredisptype
			item.measure_dispersion_type = measuredisptype
			item.save
		else
		end
	end		

	def self.compare_and_update_result_measuredispvalue(item, measuredispvalue)
		if item.measure_dispersion_value != measuredispvalue
			item.measure_dispersion_value = measuredispvalue
			item.save
		else
		end
	end		
	

	def self.compare_and_update_result_pvalue(item, pvalue)
		if item.p_value != pvalue
			item.p_value = pvalue
			item.save
		else
		end
	end		
	
end
