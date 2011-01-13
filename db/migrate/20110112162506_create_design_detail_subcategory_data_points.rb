class CreateDesignDetailSubcategoryDataPoints < ActiveRecord::Migration
  def self.up
    create_table :design_detail_subcategory_data_points do |t|
      t.integer :design_detail_subcategory_field_id

      t.timestamps
    end
  end

  def self.down
    drop_table :design_detail_subcategory_data_points
  end
end
