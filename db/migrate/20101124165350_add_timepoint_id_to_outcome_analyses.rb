class AddTimepointIdToOutcomeAnalyses < ActiveRecord::Migration
  def self.up
  	add_column :outcome_analyses, :timepoint_id, :integer
  end

  def self.down
  	remove_column :outcome_analyses, :timepoint_id
  end
end
