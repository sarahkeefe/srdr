class CreateStudies < ActiveRecord::Migration
  def self.up
    create_table :studies do |t|
      t.string :title
      t.string :type
      t.integer :num_participants
      t.text :recruitment_details
      t.text :inclusion_criteria
      t.text :exclusion_criteria

      t.timestamps
    end
  end

  def self.down
    drop_table :studies
  end
end
