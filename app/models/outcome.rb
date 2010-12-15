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
<<<<<<< HEAD
=======
	validates :title, :presence => true
>>>>>>> d22a627816a92c9078c027e9ad0f2cf5ed476d8e
	
	def self.get_title(id)
		if id.to_i > 0
		@outcome = Outcome.find(id)
		return @outcome.title
		else
			return nil
		end
	end
	
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

    # get the subgroups associated with an outcome id	
	def self.get_subgroups_array(outcome_id)
		outcome_cs = OutcomeSubgroup.where(:outcome_id => outcome_id).all
		retVal = Array.new
		
		# put the total subgroup at the front of the array
		retVal << outcome_cs[outcome_cs.length - 1]
		(0..outcome_cs.length-2).each do |i|
			retVal << outcome_cs[i]
		end
		return retVal
	end
	
	# get the timepoints associated with an outcome
	def self.get_timepoints_array(outcome_id)
		outcome_tps = OutcomeTimepoint.where(:outcome_id => outcome_id).all
		retVal = Array.new
		
		# put the baseline timepoint first
		retVal << outcome_tps[outcome_tps.length-1]
		(0..outcome_tps.length-2).each do |i|
			retVal << outcome_tps[i]
		end
		return retVal 
	end
	
	def self.get_array_of_titles(outcome_ids)
		retVal = Array.new()
		outcome_ids.each do |id|
			tmp = Outcome.find(id, :select=>'title')
			retVal << tmp.title
		end
		return retVal
	end
end
