class AddTimepointAndSubgroupIdsToColumns < ActiveRecord::Migration
  def self.up
	add_column :outcome_columns, :timepoint_id, :integer
	add_column :outcome_columns, :subgroup_id, :integer
  end

  def self.down
	remove_column :outcome_columns, :timepoint_id
	remove_column :outcome_columns, :subgroup_id  
  end
end
