class BaselineCharacteristicSubcategoryField < ActiveRecord::Base
	belongs_to :baseline_characteristic_field
	attr_accessible :subcategory_title, :units, :value, :baseline_characteristic_field_id
	validates :subcategory_title, :presence => true, :uniqueness => {:scope => :baseline_characteristic_field_id, :error_messages_for => :baseline_characteristic_field}
end
