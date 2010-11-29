class Outcome < ActiveRecord::Base
	has_many :outcome_analyses, :dependent=>:destroy
	has_many :outcome_results, :dependent=>:destroy
	has_many :outcome_timepoints, :dependent=>:destroy
	has_many :outcome_columns, :dependent=>:destroy
	has_many :outcome_subgroups, :dependent=>:destroy
	belongs_to :study
	accepts_nested_attributes_for :outcome_timepoints, :allow_destroy => true
	accepts_nested_attributes_for :outcome_columns, :allow_destroy => true	
	accepts_nested_attributes_for :outcome_subgroups, :allow_destroy => true	
	attr_accessible :study_id, :title, :is_primary, :units, :description, :notes, :outcome_timepoints_attributes, :outcome_columns_attributes, :outcome_subgroups_attributes, :outcome_subgroup_levels_attributes
	validates :title, :presence => true
	
	def self.get_timepoints(outcome_id)
		@outcome_tps = OutcomeTimepoint.where(:outcome_id => outcome_id).all
		tp_array = []
		for i in @outcome_tps
			tp_array << i.number.to_s + " " + i.time_unit
		end
		tp_list = tp_array.join(', ')
		return tp_list 
	end
	
	def self.get_subgroups(outcome_id)
		@outcome_cs = OutcomeSubgroup.where(:outcome_id => outcome_id).all
		c_array = []
		for i in @outcome_cs
			if i.title.to_s != "Total"
				c_array << i.title.to_s
			end
		end
		c_list = c_array.join(', ')
		return c_list 
	end	

	def self.get_subgroups_array(outcome_id)
		@outcome_cs = OutcomeSubgroup.where(:outcome_id => outcome_id).all
		return @outcome_cs 
	end
	
	def self.get_timepoints_array(outcome_id)
		@outcome_tps = OutcomeTimepoint.where(:outcome_id => outcome_id).all
		return @outcome_tps 
	end
	
end
