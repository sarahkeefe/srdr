class Project < ActiveRecord::Base
	has_many :studies
	has_many :key_questions
end
