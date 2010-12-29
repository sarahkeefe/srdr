class QualityDimensionDataPoint < ActiveRecord::Base

def self.get_data_point_notes(field, study_id)
	@qddp = QualityDimensionDataPoint.where(:quality_dimension_field_id => field.id, :study_id => study_id).first
	if @qddp.nil?
		return ""
	else
		return @qddp.notes
	end
end

def self.get_data_point(field, study_id)
	@qddp = QualityDimensionDataPoint.where(:quality_dimension_field_id => field.id, :study_id => study_id).first
	if @qddp.nil?
		return ""
	else
		return @qddp.value
	end
end

end
