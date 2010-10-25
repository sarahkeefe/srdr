class Project < ActiveRecord::Base
	has_many :studies
	has_many :key_questions
	has_many :arms, :through => :studies	
	accepts_nested_attributes_for :key_questions, :allow_destroy => true

end
