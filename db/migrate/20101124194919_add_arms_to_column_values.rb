class AddArmsToColumnValues < ActiveRecord::Migration
  def self.up
	add_column :outcome_column_values, :arm_id, :integer
	add_column :outcome_column_values, :column_id, :integer
  end

  def self.down
	remove_column :outcome_column_values, :arm_id
	remove_column :outcome_column_values, :column_id
  end
end
