class AddFieldsToDdsubdatapoints < ActiveRecord::Migration
  def self.up
	add_column :design_detail_subcategory_data_points, :value, :string
	add_column :design_detail_subcategory_data_points, :notes, :string
  end

  def self.down
	remove_column :design_detail_subcategory_data_points, :value
	remove_column :design_detail_subcategory_data_points, :notes  
  end
end
