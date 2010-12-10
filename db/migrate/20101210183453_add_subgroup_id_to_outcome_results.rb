class AddSubgroupIdToOutcomeResults < ActiveRecord::Migration
  def self.up
  	add_column :outcome_results, :subgroup_id, :integer
  	add_column :outcome_results, :timepoint_id, :integer
  end

  def self.down
  	remove_column :outcome_results, :subgroup_id
  	remove_column :outcome_results, :timepoint_id
  end
end
