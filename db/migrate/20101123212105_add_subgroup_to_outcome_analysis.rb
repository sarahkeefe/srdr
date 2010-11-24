class AddSubgroupToOutcomeAnalysis < ActiveRecord::Migration
  def self.up
  	add_column :outcome_analyses, :subgroup, :string
  end

  def self.down
  	remove_column :outcome_analyses, :subgroup
  end
end
