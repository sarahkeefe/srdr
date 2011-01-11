class PrimaryPublicationNumber < ActiveRecord::Base
	belongs_to :primary_publication
	attr_accessible :primary_publication_id, :number, :number_type
end
