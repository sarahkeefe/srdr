class Project < ActiveRecord::Base
	has_many :studies
	has_many :key_questions
	has_many :arms, :through => :studies	
end
