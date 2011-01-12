class DesignDetailDataPoint < ActiveRecord::Base
	belongs_to :design_detail_field
	
	def self.get_data_point(detail_field, subcat)
		if subcat.nil?
			@all = DesignDetailDataPoint.where(:design_detail_field_id => detail_field.id).first
		else
			@all = DesignDetailSubcategoryDataPoint.where(:design_detail_subcategory_field_id => subcat.id).first
		end
		if @all.nil?
			return ""
		else
			return @all.value
		end
	end
	
def self.save_data_point_info(study_id, params)
	for i in params
		if i[0].starts_with? "value"
			save_data_point(study_id, i)
		end
	end
end
	
def self.save_data_point(study_id, param)
	#get study template
	@study_t = StudyTemplate.where(:study_id => study_id).first
	if !@study_t.nil?
		@study_template = CustomTemplate.find(@study_t.template_id)
	end

	# parse parameter string
	# gives [value],[tmplX] OR [value],[custom]
	@both_arr = param[0].split("_")
	
	# test if template or custom field
	# i don't think I'm doing anything with this really
	if @both_arr[1].starts_with? "tmpl"
		@tmpl_arr = @both_arr[1].split("tmpl")
		tmpl_id = @tmpl_arr[1]
	end
	
	# param[1] gives data hash for that parameter
	# param[1][0] gives first hash element, etc
	@data_hash = param[1]
	
	# go through each item in the parameter hash
	# each item has layout [field-id_subcategory-id], [value]
	#save value for each field-id and subcategory-id, with above arm_id and tmpl_id
	for item in @data_hash
		@item_arr = item[0].split("_")
		field_id = @item_arr[0].to_i
		subcategory_id = @item_arr[1].to_i
		value = @item_arr[1]
		
		if subcategory_id == -1
			# no subcategory
			# first test if this exists
			@data_point_existing = DesignDetailDataPoint.where(:design_detail_field_id => field_id, :study_id => study_id).first
			if !@data_point_existing.nil?
				# if not nil => data point exists
				# update existing data point
				@data_point_existing.value = item[1]
				@data_point_existing.save
			else
				# create new data point
				# save to design_detail_data_points
				@data_point = DesignDetailDataPoint.new
				@data_point.design_detail_field_id = field_id
				@data_point.value = item[1]
				@data_point.study_id = study_id
				@data_point.save
			end
		else
			# has subcategory
			# first test if this exists
			@data_point_existing = DesignDetailSubcategoryDataPoint.where(:design_detail_subcategory_field_id => subcategory_id, :study_id => study_id).first
			if !@data_point_existing.nil?
				# if not nil => data point exists
				# update existing data point
				@data_point_existing.value = item[1]
				@data_point_existing.save
			else	
				# create new data point
				#	save to design_detail_subcategory_data_points
				@data_point = DesignDetailSubcategoryDataPoint.new
				@data_point.design_detail_subcategory_field_id = subcategory_id
				@data_point.value = item[1]
				@data_point.study_id = study_id
				@data_point.save
			end
		end
	end
end
	
end
