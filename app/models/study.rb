class Study < ActiveRecord::Base
	belongs_to :project
	has_many :arms
	#has_many :outcome_analyses, through => :outcomes
	#has_many :outcome_results, through => :outcomes
	has_many :outcome_timepoints
	#has_many :outcome_enrolled_numbers, through => :outcomes
	has_many :outcomes
	has_many :key_questions
	#has_many :population_characteristics, through => :arms
	#has_many :adverse_event_arms, through => :adverse_event
	has_many :adverse_events
	has_many :quality_aspects
	has_one :quality_rating
	has_many :publications
	attr_accessible :study_type
	
	
	#has_and_belongs_to_many :key_questions

	def self.get_arms(study_id)
		return Arm.where(:study_id => study_id)
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
		i = 0
		studies.each do |study|
		  tmp = sql.execute("SELECT ui, title, author, year FROM publications WHERE publications.study_id = #{study['id']} AND publications.is_primary = 't'")
		  
		  tmp = [tmp[0]["ui"],tmp[0]["title"], tmp[0]["author"], tmp[0]["year"]]
		  titles[i] = tmp
		  i += 1
		end
		return(titles)
	end
	
end
