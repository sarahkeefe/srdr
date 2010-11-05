class ChangeOutcomeNameToOutcomeTitle < ActiveRecord::Migration
  def self.up
	add_column :outcome_analyses, :outcome_id, :integer
	remove_column :outcome_analyses, :outcome_name
  end

  def self.down
 	remove_column :outcome_analyses, :outcome_id
	add_column :outcome_analyses, :outcome_name, :string 
  end
end