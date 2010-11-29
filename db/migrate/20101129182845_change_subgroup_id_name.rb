class ChangeSubgroupIdName < ActiveRecord::Migration
  def self.up
	remove_column :outcome_subgroup_levels, :subgroup_id
	add_column :outcome_subgroup_levels, :outcome_subgroup_id, :integer
  end

  def self.down
  	remove_column :outcome_subgroup_levels, :outcome_subgroup_id
	add_column :outcome_subgroup_levels, :subgroup_id, :integer	
  end
end
