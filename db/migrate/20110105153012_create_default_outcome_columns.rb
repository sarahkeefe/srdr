class CreateDefaultOutcomeColumns < ActiveRecord::Migration
  def self.up
    create_table :default_outcome_columns do |t|
      t.integer :study_id
      t.integer :column_id
      t.string :column_name
      t.text :column_description
      t.string :units

      t.timestamps
    end
  end

  def self.down
    drop_table :default_outcome_columns
  end
end
