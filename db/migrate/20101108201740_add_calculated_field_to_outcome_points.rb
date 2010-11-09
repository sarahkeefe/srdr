class AddCalculatedFieldToOutcomePoints < ActiveRecord::Migration
  def self.up
	add_column :outcome_timepoint_results, :is_calculated, :boolean
  end

  def self.down
	remove_column :outcome_timepoint_results, :is_calculated
  end
end
