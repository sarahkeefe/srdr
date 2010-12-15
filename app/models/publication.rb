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
  
	
	def get_display_number(study_id)
	  current_max = Publication.maximum("display_number",:conditions => ["study_id = ? AND is_primary = ?", study_id, false])
	  if (current_max.nil?)
	  	current_max = 0
	  end
		return current_max + 1
	end
	
	def shift_display_numbers(study_id)
		myNum = self.display_number
		hi_pubs = Publication.find(:all, :conditions => ["study_id = ? AND display_number > ?", study_id, myNum])
		hi_pubs.each { |pub|
		  tmpNum = pub.display_number
		  pub.display_number = tmpNum - 1
		  pub.save 
	  }
	end  
	
	def self.move_up_this(id)
		@this = Publication.find(id.to_i)
		if @this.display_number > 1
			new_num = @this.display_number - 1
			Publication.decrease_other(new_num)
			@this.display_number = new_num
			@this.save
		end
	end
	
	def self.decrease_other(num)
		@other = Publication.where(:display_number => num).first
		if !@other.nil?
			@other.display_number = @other.display_number + 1;
			@other.save
		end
	end
  
end
