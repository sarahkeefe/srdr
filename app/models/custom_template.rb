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
end
