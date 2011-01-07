class ChangeOutcomeColumnFields < ActiveRecord::Migration
  def self.up
	add_column :outcome_columns, :column_name, :string
	add_column :outcome_columns, :column_description, :string
	add_column :outcome_columns, :template_id, :integer
	add_column :outcome_columns, :study_id, :integer
	remove_column :outcome_columns, :name
	remove_column :outcome_columns, :description
	remove_column :outcome_columns, :outcome_id
	remove_column :outcome_columns, :timepoint_id
	remove_column :outcome_columns, :subgroup_id
  end

  def self.down
  end
end
