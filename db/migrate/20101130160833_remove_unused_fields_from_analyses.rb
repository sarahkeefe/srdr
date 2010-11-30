class RemoveUnusedFieldsFromAnalyses < ActiveRecord::Migration
  def self.up
  	remove_column :outcome_analyses, :categorical_or_continuous
  	remove_column :outcome_analyses, :n_analyzed
  	remove_column :outcome_analyses, :n_total
  	remove_column :outcome_analyses, :n_event
  end

  def self.down
  	add_column :outcome_analyses, :categorical_or_continuous, :string
  	add_column :outcome_analyses, :n_analyzed, :float
  	add_column :outcome_analyses, :n_total, :float
  	add_column :outcome_analyses, :n_event, :float
  end
end