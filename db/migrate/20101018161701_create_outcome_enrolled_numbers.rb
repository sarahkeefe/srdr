class CreateOutcomeEnrolledNumbers < ActiveRecord::Migration
  def self.up
    create_table :outcome_enrolled_numbers do |t|
      t.integer :arm_id
      t.integer :outcome_id
      t.integer :num_enrolled

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_enrolled_numbers
  end
end
