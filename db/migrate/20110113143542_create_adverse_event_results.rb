class CreateAdverseEventResults < ActiveRecord::Migration
  def self.up
    create_table :adverse_event_results do |t|
      t.integer :column_id
      t.string :value
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :adverse_event_results
  end
end
