class AddFieldsToDefaultColumns < ActiveRecord::Migration
  def self.up
	add_column :default_outcome_columns, :name, :string
	add_column :default_outcome_columns, :description, :string
	add_column :default_outcome_columns, :column_header, :string
	add_column :default_outcome_columns, :outcome_type, :string
  end

  def self.down
	remove_column :default_outcome_columns, :name
	remove_column :default_outcome_columns, :description
	remove_column :default_outcome_columns, :column_header
	remove_column :default_outcome_columns, :outcome_type
  end
end
