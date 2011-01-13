class ModifyFootnotesTables < ActiveRecord::Migration
  def self.up
  	change_table :footnote_fields do |t|
  		t.remove :outcome_id, :subgroup_id, :timepoint_id, :footnote_number
  		t.rename :field_name, :field_id
  		t.integer :footnote_id
  	end
  	
  	change_table :footnotes do |t|
  		t.remove :outcome_id, :subgroup_id, :timepoint_id
  		t.string :page_name
  		t.string :data_type
  	end
  end

  def self.down
  end
end
