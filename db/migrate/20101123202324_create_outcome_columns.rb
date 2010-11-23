class CreateOutcomeColumns < ActiveRecord::Migration
  def self.up
    create_table :outcome_columns do |t|
      t.integer :outcome_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_columns
  end
end
