class CreateDefaultDesignDetails < ActiveRecord::Migration
  def self.up
    create_table :default_design_details do |t|
      t.string :title
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :default_design_details
  end
end
