class ChangeSubgroupToSubgroupIdInOutcomeAnalyses < ActiveRecord::Migration
  def self.up
  	remove_column :outcome_analyses, :subgroup
  	add_column :outcome_analyses, :subgroup_id, :integer
  end

  def self.down
  	remove_column :outcome_analyses, :subgroup_id
  	add_column :outcome_analyses, :subgroup, :text
  end
end
