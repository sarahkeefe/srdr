class CreateOutcomeTimepoints < ActiveRecord::Migration
  def self.up
    create_table :outcome_timepoints do |t|
      t.integer :study_id
      t.integer :outcome_id
      t.integer :number
      t.string :time_unit

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_timepoints
  end
end
