class Outcome < ActiveRecord::Base
	has_many :outcome_analyses
	has_many :outcome_results, :dependent=>:destroy
	has_many :outcome_timepoints, :dependent=>:destroy
	has_many :outcome_columns, :dependent=>:destroy
	has_many :outcome_subgroups, :dependent=>:destroy
	belongs_to :study
	accepts_nested_attributes_for :outcome_timepoints, :allow_destroy => true
	accepts_nested_attributes_for :outcome_columns, :allow_destroy => true	
	accepts_nested_attributes_for :outcome_subgroups, :allow_destroy => true, :reject_if => proc { |attributes| attributes['title'].blank? }
	attr_accessible :study_id, :title, :is_primary, :units, :description, :notes, :outcome_timepoints_attributes, :outcome_columns_attributes, :outcome_subgroups_attributes, :outcome_subgroup_levels_attributes
	validates :title, :presence => true
	
	def self.get_timepoints(outcome_id)
		@outcome_tps = OutcomeTimepoint.where(:outcome_id => outcome_id).all
		tp_array = []
		for i in @outcome_tps
			if i.time_unit != "baseline"
				tp_array << i.number.to_s + " " + i.time_unit
			end
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
	
	def self.get_subgroups_and_levels(outcome_id)
		@outcome_cs = OutcomeSubgroup.where(:outcome_id => outcome_id).all
		c_array = []
		for i in @outcome_cs
			if i.title.to_s != "Total"
				str = ""
				@outcome_sub_levels = OutcomeSubgroupLevel.where(:outcome_subgroup_id => i.id).first
				if !@outcome_sub_levels.nil? && @outcome_sub_levels.length > 0
					str = i.title.to_s + " ("
					sub_arr = []
					for j in @outcome_sub_levels
						sub_arr << j.title.to_s
					end
					str += sub_arr.join(', ')
					str += ")"
				else
					str = i.title.to_s
				end
				c_array << str
			end
		end
		c_list = c_array.join('; ')
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
