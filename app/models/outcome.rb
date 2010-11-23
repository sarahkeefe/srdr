class Outcome < ActiveRecord::Base
	has_many :outcome_analyses
	has_many :outcome_results
	has_many :outcome_timepoints
	has_many :outcome_enrolled_numbers
	has_many :outcome_columns
	belongs_to :study
	accepts_nested_attributes_for :outcome_timepoints, :allow_destroy => true
	accepts_nested_attributes_for :outcome_enrolled_numbers, :allow_destroy => true
	accepts_nested_attributes_for :outcome_columns, :allow_destroy => true	
	attr_accessible :outcome_type, :study_id, :title, :is_primary, :units, :description, :notes, :arm_id, :outcome_id, :num_enrolled, :outcome_timepoints_attributes, :outcome_columns_attributes
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
	
	def self.get_columns(outcome_id)
		@outcome_cs = OutcomeColumn.where(:outcome_id => outcome_id).all
		c_array = []
		for i in @outcome_cs
			c_array << i.name.to_s
		end
		c_list = c_array.join(', ')
		return c_list 
	end	

	def self.get_columns_array(outcome_id)
		@outcome_cs = OutcomeColumn.where(:outcome_id => outcome_id).all
		return @outcome_cs 
	end
	
	def self.get_tp_col_array(outcome_id)
		@all_arr = []
		@outcome_cs = OutcomeColumn.where(:outcome_id => outcome_id).all
		@outcome_tps = OutcomeTimepoint.where(:outcome_id => outcome_id).all
		for i in @outcome_tps
			@new_chunk = Hash["object" => i, "type" => "timepoint"]
			@all_arr << @new_chunk
		end
		for i in @outcome_cs
			@new_chunk = Hash["object" => i, "type" => "column"]
			@all_arr << @new_chunk
		end
		return @all_arr
	end
	
	def self.get_timepoints_array(outcome_id)
		@outcome_tps = OutcomeTimepoint.where(:outcome_id => outcome_id).all
		return @outcome_tps 
	end
	
	def self.getNumEnrolledByArm(outcome_id, arm_id)
		num = OutcomeEnrolledNumber.where(:arm_id => arm_id, :outcome_id => outcome_id).all
		if num.length > 0
			return num[0].num_enrolled
		else
			return nil
		end
	end
	
		def self.arm_enrolled_num_exists(outcome_id, arm_id, value)
			print "\nChecking for existence\n"
			print "-------------------Outcome ID is #{outcome_id}----------------\n"
			print "-------------------Arm ID is #{arm_id} ------------------------\n"
			print "-------------------Value is #{value}---------------------------\n"
			oen = OutcomeEnrolledNumber.where(:outcome_id => outcome_id, :arm_id => arm_id).first
			if oen.nil?
				return false
			else
				return true
			end
		end
		
		def self.update_arm_enrolled_number(outcome_id, arm_id, value)
			
			oen = OutcomeEnrolledNumber.where(:outcome_id=>outcome_id, :arm_id=>arm_id).first
			unless oen.nil?
				print "----------------- I'm UPDATING THE OEN ----------------\n"
				print "-------------------Outcome ID is #{outcome_id}.----------------\n"
				print "-------------------Arm ID is #{arm_id} ------------------------\n"
				print "-------------------Value is #{value}---------------------------\n"	
				oen.num_enrolled = value.to_i
				oen.save
			else
				OutcomeEnrolledNumber.create(:arm_id=>arm_id,
															:outcome_id=>outcome_id,
															:num_enrolled=>value.to_i,
															:created_at=>Time.now)
			end
		end
end
