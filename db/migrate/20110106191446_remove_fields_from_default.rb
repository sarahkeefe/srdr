class RemoveFieldsFromDefault < ActiveRecord::Migration
  def self.up
	remove_column :default_outcome_columns, :name
	remove_column :default_outcome_columns, :description
	remove_column :default_outcome_columns, :units
	remove_column :default_outcome_columns, :study_id
	remove_column :default_outcome_columns, :column_id				
  end

  def self.down
  end
end
