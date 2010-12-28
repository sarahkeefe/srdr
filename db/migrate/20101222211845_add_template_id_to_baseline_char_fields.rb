class AddTemplateIdToBaselineCharFields < ActiveRecord::Migration
  def self.up
	add_column :baseline_characteristic_fields, :template_id, :integer
  end

  def self.down
	remove_column :baseline_characteristic_fields, :template_id
  end
end
