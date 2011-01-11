class PrimaryPublication < ActiveRecord::Base
	has_many :primary_publication_numbers, :dependent => :destroy
	accepts_nested_attributes_for :primary_publication_numbers, :allow_destroy => true	
end
