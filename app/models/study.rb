class Study < ActiveRecord::Base
	belongs_to :project
	has_many :arms
	has_many :outcome_analyses, :through => :outcomes
	has_many :outcome_results, :through => :outcomes
	has_many :outcome_timepoints, :through => :outcomes
	has_many :outcome_enrolled_numbers, :through => :outcomes
	has_many :outcomes
	has_many :key_questions
	has_many :population_characteristics
	has_many :adverse_event_arms, :through => :adverse_event
	has_many :adverse_events
	has_many :quality_aspects
	has_one :quality_rating
	has_many :publications
	attr_accessible :study_type, :recruitment_details, :inclusion_criteria, :exclusion_criteria, :num_participants, :outcome_attributes

	def self.get_arms(study_id)
		return Arm.where(:study_id => study_id).all
	end
	
	def self.get_attributes(study_id)
		return PopulationCharacteristic.where(:study_id => study_id)
	end
	
	def get_question_choices(project_id)
		questions = KeyQuestion.find(:all, :order => "question_number ASC", :conditions => ["project_id = ?", project_id])
		return(questions)
	end
	
	def assign_questions(questions)
		sql = ActiveRecord::Base.connection()
		sql.begin_db_transaction
		sql.delete "DELETE FROM studies_key_questions WHERE studies_key_questions.study_id = #{self.id}"
		sql.commit_db_transaction
		
		questions.each do |q_id|
			sql.begin_db_transaction
			sql.insert "INSERT into studies_key_questions (study_id, key_question_id) VALUES (#{self.id},#{q_id})"
			sql.commit_db_transaction
		end
	end
	def get_questions_addressed
		
		questions_array = Array.new
		sql = ActiveRecord::Base.connection()
		question_ids = sql.execute "SELECT key_question_id FROM studies_key_questions WHERE study_id = #{self.id}"
		
		unless(question_ids.empty?)
			  question_ids.each do |q_hash|
					question_info = sql.execute "SELECT id, question_number, question FROM key_questions WHERE id = #{q_hash["key_question_id"]}"
				  questions_array.push([ question_info[0]["id"], question_info[0]["question_number"], question_info[0]["question"] ] )
				end
		end
		return (questions_array)
	end
	
	# given an array of studies, return another array of formatted 
	# strings that show the questions addressed for each study 
	# example 1, 3 and 4
	def self.get_addressed_question_numbers_for_studies(studies)
			return_array = Array.new

			studies.each do |study|
				questions = Array.new
				q_addressed = StudiesKeyQuestion.where(:study_id=>study.id)
								
				q_addressed.each do |q|
				  questions << KeyQuestion.where(:id=>q.key_question_id)[0]
				end
				return_array << KeyQuestion.format_for_display(questions)
		 end
		 return return_array
	end
	
	def get_addressed_ids
		ids_only = Array.new
		questions = get_questions_addressed
		questions.each do |q|
		  ids_only.push(q[0])	
		end
		return ids_only
	end
	
	def remove_from_junction
		sql = ActiveRecord::Base.connection()
		sql.begin_db_transaction
		sql.delete "DELETE FROM studies_key_questions WHERE studies_key_questions.study_id = #{self.id}"
		sql.commit_db_transaction
	end
	
	def get_primary_publication
	  primary = Publication.find(:first, :conditions => ["study_id = ? AND is_primary = ?", self.id, true])
	  return primary
	end  
	
	def get_secondary_publications
		secondary = Publication.find(:all, :conditions => ["study_id = ? AND is_primary = ?",self.id, false])
		return secondary
	end
	
	# return an array of study titles, which are taken from the title
	# of the primary publication associated with that study
	def self.get_ui_title_author_year(studies)
		sql = ActiveRecord::Base.connection()
		titles = []
		if !studies.nil?
			studies.each do |study|
				tmp = Publication.where(:study_id => study.id, :is_primary => true).first
			 	tmp0 = []
				tmp0 << tmp.ui
				tmp0 << tmp.title
				tmp0 << tmp.author
				tmp0 << tmp.year
				titles << tmp0
			end
		end
		return(titles)
	end
	
	def self.get_primary_pub_info(study_id)
			tmp = Publication.where(:study_id => study_id, :is_primary => true).first
			if tmp.nil?
				tmppub = Publication.new
				tmppub.ui = "Not Entered Yet"
				tmppub.title = "Not Entered Yet"
				tmppub.author = "-"
				tmppub.year = "-"
				return tmppub
			else
				return tmp
			end
	end
	
	def self.get_key_question_output(study_id)
		@s_keyqs = StudiesKeyQuestion.where(:study_id => study_id).all
		@keyqs = []

		for k in @s_keyqs
			@keyqs << KeyQuestion.find(k.key_question_id)
		end

		arr = []
		for q in @keyqs
			arr << q.question_number.to_s
		end
		print arr.inspect		
		return arr
	end
	
end
