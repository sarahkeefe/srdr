class AddTotalToEnrolledNumbers < ActiveRecord::Migration
  def self.up
	add_column :outcome_enrolled_numbers, :is_total, :boolean
  end

  def self.down
	remove_column :outcome_enrolled_numbers, :is_total
  end
end
