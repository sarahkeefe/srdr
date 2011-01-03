class AddFieldTypeToQualityAspects < ActiveRecord::Migration
  def self.up
	add_column :quality_dimension_data_points, :field_type, :string
  end

  def self.down
	remove_column :quality_dimension_data_points, :field_type  
  end
end
