class OutcomeColumn < ActiveRecord::Base
	belongs_to :outcome
	has_many :outcome_column_values
	attr_accessible :outcome_type, :template_id, :column_name, :column_header, :column_description
	#validates :name, :presence => true
	
end
