class OutcomeSubgroup < ActiveRecord::Base
	has_many :outcome_subgroup_levels
	attr_accessible :title, :description, :outcome_subgroup_levels_attributes
	validates :title, :presence => true, :uniqueness => {:scope => :outcome_id, :error_messages_for => :outcome}
	accepts_nested_attributes_for :outcome_subgroup_levels, :allow_destroy => true
	
	def self.get_title(id)
		@subgroup = OutcomeSubgroup.find(id)
		return @subgroup.title
	end
	
	def self.total_subgroup_exists(outcome_id)
		@exists = OutcomeSubgroup.where(:outcome_id => outcome_id, :title => "Total").first
		if @exists.nil?
			return false
		else return true
		end
	end
end
