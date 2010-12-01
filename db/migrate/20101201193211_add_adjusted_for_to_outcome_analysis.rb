class AddAdjustedForToOutcomeAnalysis < ActiveRecord::Migration
  def self.up
  	add_column :outcome_analyses, :adjusted_for, :string
  end

  def self.down
  	remove_column :outcome_analyses, :adjusted_for
  end
end
