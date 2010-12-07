class Publication < ActiveRecord::Base
	validates :title, :presence => true, :length => { :minimum => 4}
	#validates :author, :presence => true, :length => { :minimum => 4}
	#validates :country, :presence => true
	#validates :year, :presence => true
	has_many :publication_numbers, :dependent => :destroy
	accepts_nested_attributes_for :publication_numbers, :allow_destroy => true	
  
	def self.get_pub_uis(pub_id)
		return PublicationNumber.where(:publication_id => pub_id).all
	end
  
end
