class Project < ActiveRecord::Base
	has_many :studies
	has_many :key_questions
	has_many :arms, :through => :studies	
	accepts_nested_attributes_for :key_questions, :allow_destroy => true
	validates :title, :presence => true, :length => { :minimum => 4}
	
	def self.get_num_studies(project)
		pid = project.id
		@studies = Study.where(:project_id => pid).all
		return @studies.length
	end
	
	def self.get_num_key_qs(project)
		pid = project.id
		@key_qs = KeyQuestion.where(:project_id => pid).all
		return @key_qs.length
	end
	
	def self.moveup(project_id, keyq)
		@proj = Project.find(project_id)
		keyq_id = keyq.id
		if keyq.question_number > 1
			keyq.question_number = keyq.question_number - 1
			@proj_kqs = KeyQuestion.where(:project_id => @proj.id)
			for kq in @proj_kqs
				if (kq.question_number == keyq.question_number) && (kq.id != keyq.id)
					kq.question_number = kq.question_number + 1
					kq.save
				end
			end
		end
			if keyq.save  
				format.js {
					render :update do |page|
						page.replace_html 'key_question_table', :partial => 'key_questions/table'
					end
				}
			end
	end
	
end
