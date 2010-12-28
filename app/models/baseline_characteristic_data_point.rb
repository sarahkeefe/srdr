class BaselineCharacteristicDataPoint < ActiveRecord::Base
	belongs_to :baseline_characteristic_field
	
	def self.get_data_point(arm_id, popchar, subcat, is_total)
		if subcat.nil?
			@all = BaselineCharacteristicDataPoint.where(:arm_id => arm_id, :baseline_characteristic_field_id => popchar.id, :is_total => is_total).first
		else
			@all = BaselineCharacteristicSubcategoryDataPoint.where(:arm_id => arm_id, :baseline_characteristic_subcategory_field_id => subcat.id, :is_total => is_total).first
		end
		if @all.nil?
			return ""
		else
			return @all.value
		end
	end
	
def self.save_data_point(param, study_id, is_total)
	#get study arms
	@study_arms = Study.get_arms(study_id)
	
	#get study template
	@study_t = StudyTemplate.where(:study_id => study_id).first
	@study_template = Template.find(@study_t.template_id)
	
	# parse parameter string
	# gives [armXXX], [tmplYYY]
	@both_arr = param[0].split("_")
	
	# test if this is a total value
	if !is_total
		# gives [], [XXX]
		@arm_arr = @both_arr[0].split("arm")
		arm_id = @arm_arr[1]
	else
		arm_id = nil
	end
	
	# test if template or custom field
	# i don't think I'm doing anything with this really
	if @both_arr[1].starts_with? "tmpl"
		# gives [], [YYY]
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
			@data_point_existing = BaselineCharacteristicDataPoint.where(:baseline_characteristic_field_id => field_id, :arm_id => arm_id, :is_total => is_total, :study_id => study_id).first
			if !@data_point_existing.nil?
				# if not nil => data point exists
				# update existing data point
				@data_point_existing.value = item[1]
				@data_point_existing.save
			else
				# create new data point
				# save to baseline_characteristic_data_points
				@data_point = BaselineCharacteristicDataPoint.new
				@data_point.baseline_characteristic_field_id = field_id
				@data_point.arm_id = arm_id
				@data_point.is_total = is_total
				@data_point.value = item[1]
				@data_point.study_id = study_id
				@data_point.save
			end
		else
			# has subcategory
			# first test if this exists
			@data_point_existing = BaselineCharacteristicSubcategoryDataPoint.where(:baseline_characteristic_subcategory_field_id => subcategory_id, :arm_id => arm_id, :is_total => is_total).first
			if !@data_point_existing.nil?
				# if not nil => data point exists
				# update existing data point
				@data_point_existing.value = item[1]
				@data_point_existing.save
			else	
				# create new data point
				#	save to baseline_characteristic_subcategory_data_points
				@data_point = BaselineCharacteristicSubcategoryDataPoint.new
				@data_point.baseline_characteristic_subcategory_field_id = subcategory_id
				@data_point.arm_id = arm_id
				@data_point.is_total = is_total
				@data_point.value = item[1]
				@data_point.save
			end
		end
	end
end

	
def self.save_data_point_info(study_id, params)
	# reset max id to avoid errors
	#BaselineCharacteristicDataPoint.connection.execute "select setval('baseline_characteristic_data_points_id_seq', (select max(id) + 1 from baseline_characteristic_data_points));"
	
	for i in params
		if  i[0].starts_with? "arm"
			BaselineCharacteristicDataPoint.save_data_point(i, study_id, false)
		elsif i[0].starts_with? "total"
			BaselineCharacteristicDataPoint.save_data_point(i, study_id, true)		
		end
	end
end
	
end
