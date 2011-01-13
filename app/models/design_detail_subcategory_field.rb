class DesignDetailSubcategoryField < ActiveRecord::Base
	belongs_to :design_detail_field
	attr_accessible :subcategory_title, :units, :value, :design_detail_field_id
	validates :subcategory_title, :presence => true, :uniqueness => {:scope => :design_detail_field_id, :error_messages_for => :design_detail_field}
end
