class AddStudyIdToBaselineFields < ActiveRecord::Migration
  def self.up
	add_column :baseline_characteristic_fields, :study_id, :integer
	add_column :baseline_characteristic_data_points, :study_id, :integer
  end

  def self.down
	remove_column :baseline_characteristic_fields, :study_id
	remove_column :baseline_characteristic_data_points, :study_id  
  end
end
