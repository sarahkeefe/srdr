class AddStudyIdToQualityDatapoints < ActiveRecord::Migration
  def self.up
	add_column :quality_dimension_data_points, :study_id, :integer
  end

  def self.down
	remove_column :quality_dimension_data_points, :study_id  
  end
end
