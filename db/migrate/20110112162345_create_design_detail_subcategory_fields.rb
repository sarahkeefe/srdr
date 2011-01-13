class CreateDesignDetailSubcategoryFields < ActiveRecord::Migration
  def self.up
    create_table :design_detail_subcategory_fields do |t|
      t.string :subcategory_title
      t.integer :design_detail_field_id

      t.timestamps
    end
  end

  def self.down
    drop_table :design_detail_subcategory_fields
  end
end
