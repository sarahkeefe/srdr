class ChangeOutcomeTypeFieldname < ActiveRecord::Migration
  def self.up
	add_column :outcomes, :outcome_type, :string
	remove_column :outcomes, :type
  end

  def self.down
 	remove_column :outcomes, :outcome_type
	add_column :outcomes, :type, :string 
  end
end
