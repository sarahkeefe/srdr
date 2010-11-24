class RemoveOutcomeTypeFromOutcomes < ActiveRecord::Migration
  def self.up
	remove_column :outcomes, :outcome_type
  end

  def self.down
	add_column :outcomes, :outcome_type, :string
  end
end
