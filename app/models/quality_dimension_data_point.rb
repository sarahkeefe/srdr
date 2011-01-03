class QualityDimensionDataPoint < ActiveRecord::Base

def self.get_data_point(field, study_id, field_type)
	@qddp = QualityDimensionDataPoint.where(:quality_dimension_field_id => field.id, :study_id => study_id, :field_type => field_type).first
	if @qddp.nil?
		return ""
	else
		return @qddp.value
	end
end

def self.save_data_point(param, study_id)
	#get study template
	@study_t = StudyTemplate.where(:study_id => study_id).first
	@study_template = Template.find(@study_t.template_id)
	
	# parse parameter string
	# gives ["quality"], ["value"|"notes"]
	@both_arr = param[0].split("_")
	field_type = @both_arr[1]
	
	@data_hash = param[1]
	for item in @data_hash
		val = item[1]
		field_id = item[0].to_i		
	end
	
	#save data to quality_dimension_data_points
	@qddp_exists = QualityDimensionDataPoint.where(:quality_dimension_field_id => field_id, :field_type => field_type, :study_id => study_id).first
	if !@qddp_exists.nil?
		@qddp_exists.value = val
		@qddp_exists.save
	else
		@qddp_new = QualityDimensionDataPoint.new
		@qddp_new.quality_dimension_field_id = field_id
		@qddp_new.value = val
		@qddp_new.study_id = study_id
		@qddp_new.field_type = field_type
		@qddp_new.save
	end
end

	
def self.save_data_point_info(study_id, params)
	# reset max id to avoid errors
	#QualityDimensionDataPoint.connection.execute "select setval('quality_dimension_data_points_id_seq', (select max(id) + 1 from quality_dimension_data_points));"
	
	for i in params
		if  i[0].starts_with? "quality_"
			QualityDimensionDataPoint.save_data_point(i, study_id)
		end
	end
end

end
