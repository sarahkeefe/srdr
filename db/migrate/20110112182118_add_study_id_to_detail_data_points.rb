class AddStudyIdToDetailDataPoints < ActiveRecord::Migration
  def self.up
	add_column :design_detail_data_points, :study_id, :integer
	add_column :design_detail_subcategory_data_points, :study_id, :integer
  end

  def self.down
	remove_column :design_detail_data_points, :study_id
	remove_column :design_detail_subcategory_data_points, :study_id  
  end
end
