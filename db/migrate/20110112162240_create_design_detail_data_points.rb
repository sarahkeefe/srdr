class CreateDesignDetailDataPoints < ActiveRecord::Migration
  def self.up
    create_table :design_detail_data_points do |t|
      t.integer :design_detail_field_id
      t.string :value
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :design_detail_data_points
  end
end
