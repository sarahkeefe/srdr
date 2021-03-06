class KeyQuestion < ActiveRecord::Base
	belongs_to :project
	#has_and_belongs_to_many :studies
	validates :question, :presence => true
	
	def get_question_number(project_id)
		current_max = KeyQuestion.maximum("question_number",:conditions => ["project_id = ?",project_id])
	  if (current_max.nil?)
	  	current_max = 0
	  end
		return current_max + 1
	end
	
	def shift_question_numbers(project_id)
		myNum = self.question_number
		higher_questions = KeyQuestion.find(:all, :conditions => ["project_id = ? AND question_number > ?", project_id, myNum])
		higher_questions.each { |question|
		  tmpNum = question.question_number
		  question.question_number = tmpNum - 1
		  question.save 
	  }
	end
	
	def remove_from_junction
		sql = ActiveRecord::Base.connection()
		sql.begin_db_transaction
		sql.delete "DELETE FROM studies_key_questions WHERE studies_key_questions.key_question_id = #{self.id}"
		sql.commit_db_transaction
	end
	
	def self.format_for_display(questions)
		kq_string = ""
		i = 1

		questions.each do |kq|
			if(i < (questions.length - 1))
				kq_string = kq_string + kq.question_number.to_s + ", "
			elsif( i < questions.length )
				kq_string = kq_string + kq.question_number.to_s + " and " 
			else
				kq_string = kq_string + kq.question_number.to_s
			end
		i = i+1
		end
		return(kq_string)

	end
	
	def self.move_up_this(id, study_id)
		@this = KeyQuestion.find(id.to_i)
		if @this.question_number > 1
			new_num = @this.question_number - 1
			KeyQuestion.decrease_other(new_num, study_id)
			@this.question_number = new_num
			@this.save
		end
	end
	
	def self.decrease_other(num, study_id)
		@other = KeyQuestion.where(:study_id => study_id,:question_number => num).first
		if !@other.nil?
			@other.question_number = @other.question_number + 1;
			@other.save
		end
	end
  	
	
end