class AddOutcomeTypeToColumns < ActiveRecord::Migration
  def self.up
	add_column :outcome_columns, :outcome_type, :string
  end

  def self.down
	remove_column :outcome_columns, :outcome_type
  end
end
