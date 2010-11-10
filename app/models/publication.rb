class Publication < ActiveRecord::Base
	validates :title, :presence => true, :length => { :minimum => 4}
	validates :author, :presence => true, :length => { :minimum => 4}
	validates :country, :presence => true
	validates :year, :presence => true
	
  
end
