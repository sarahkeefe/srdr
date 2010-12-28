class BaselineCharacteristicField < ActiveRecord::Base
	belongs_to :study
	has_many :baseline_characteristic_data_points, :through => :study_baseline_characteristic_field
	has_many :baseline_characteristic_subcategory_fields, :dependent=>:destroy
	accepts_nested_attributes_for :baseline_characteristic_subcategory_fields, :allow_destroy => true

	def self.get_category_ids_string(study_id)
		str = ""
		cat_list = BaselineCharacteristicField.where(:study_id => study_id).all
		for i in cat_list
			@subcat_list = BaselineCharacteristicSubcategoryField.where(:baseline_characteristic_field_id => i.id).all
			str += i.id.to_s + ":"
			for j in @subcat_list
				str += j.id.to_s + "-"
			end
			str += " "
		end
		return str
	end
	
	def self.get_arm_ids_string(arm_list)
		str = ""
		for i in arm_list
			str += i.id.to_s + " "
		end
		return str
	end

	def self.get_subcategory_ids_string(subcat_list)
		str = ""
		for i in subcat_list
			str += subcat_list.id + " "
		end
		return str
	end	

	
end
