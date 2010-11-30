class UpdateTimepointAndSubgroupIDsForAnalyses < ActiveRecord::Migration
  def self.up
  	remove_column :outcome_analyses, :timepoint_id
  	remove_column :outcome_analyses, :subgroup_id
  	add_column :outcome_analyses, :timepoint_comp, :string
  	add_column :outcome_analyses, :subgroup_comp, :string
  end

  def self.down
  	add_column :outcome_analyses, :timepoint_id, :integer
  	add_column :outcome_analyses, :subgroup_id, :integer
  	remove_column :outcome_analyses, :timepoint_comp
  	remove_column :outcome_analyses, :subgroup_comp
  end
end
