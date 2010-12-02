class CreateOutcomeResultsNotes < ActiveRecord::Migration
  def self.up
    create_table :outcome_results_notes do |t|
      t.integer :outcome_id
      t.integer :timepoint_id
      t.integer :subgroup_id
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_results_notes
  end
end
