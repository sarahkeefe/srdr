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
	
end
