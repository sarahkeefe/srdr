class CustomTemplate < ActiveRecord::Base
	#has_many :baseline_characteristic_fields, :dependent=>:destroy
	#has_many :quality_dimension_fields, :dependent=>:destroy
	
	def self.create_default_outcome_columns(template_id)
		@default_columns = DefaultOutcomeColumn.all
		for i in @default_columns
			@new_col = OutcomeColumn.new
			@new_col.column_header = i.column_header
			@new_col.outcome_type = i.outcome_type
			@new_col.column_name = i.column_name
			@new_col.column_description = i.column_description
			@new_col.template_id = template_id
			@new_col.save
		end
	end
	
	def self.create_default_outcome_comparison_columns(template_id)
		@default_comparison_columns = DefaultOutcomeComparisonColumn.all
		for i in @default_comparison_columns
			@new_col = OutcomeComparisonColumn.new
			@new_col.column_header = i.column_header
			@new_col.outcome_type = i.outcome_type
			@new_col.column_name = i.column_name
			@new_col.column_description = i.column_description
			@new_col.template_id = template_id
			@new_col.save
		end
	end	
	
	def self.create_default_design_details(template_id)
		@default_design_details = DefaultDesignDetail.all
		for i in @default_design_details
			@new_category = DesignDetailField.new
			@new_category.title = i.title
			@new_category.field_notes = i.notes
			@new_category.template_id = template_id
			@new_category.save
		end
	end
	
end
