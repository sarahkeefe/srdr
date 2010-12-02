class PublicationNumber < ActiveRecord::Base
	belongs_to :publication
	attr_accessible :publication_id, :number, :number_type
end
