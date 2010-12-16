class CreateFootnotes < ActiveRecord::Migration
  def self.up
    create_table :footnotes do |t|
      t.integer :note_number
      t.integer :study_id
      t.integer :outcome_id
      t.integer :subgroup_id
      t.integer :timepoint_id
      t.string :note_text

      t.timestamps
    end
  end

  def self.down
    drop_table :footnotes
  end
end
