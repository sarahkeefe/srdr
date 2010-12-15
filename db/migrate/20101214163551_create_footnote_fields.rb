class CreateFootnoteFields < ActiveRecord::Migration
  def self.up
    create_table :footnote_fields do |t|
      t.integer :study_id
      t.integer :outcome_id
      t.integer :subgroup_id
      t.integer :timepoint_id
      t.integer :footnote_number
      t.string :field_name

      t.timestamps
    end
  end

  def self.down
    drop_table :footnote_fields
  end
end
