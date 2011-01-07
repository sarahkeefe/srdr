class AddHeaderFieldToColumns < ActiveRecord::Migration
  def self.up
	add_column :outcome_columns, :column_header, :string
  end

  def self.down
	remove_column :outcome_columns, :column_header
  end
end
