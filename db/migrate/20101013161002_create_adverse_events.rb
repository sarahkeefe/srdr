class CreateAdverseEvents < ActiveRecord::Migration
  def self.up
    create_table :adverse_events do |t|
      t.integer :study_id
      t.string :title
      t.string :timeframe
      t.text :description
      t.boolean :is_serious
      t.string :definition_used

      t.timestamps
    end
  end

  def self.down
    drop_table :adverse_events
  end
end
