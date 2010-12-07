class AddNumberToAdverseEvent < ActiveRecord::Migration
  def self.up
	add_column :adverse_events, :number, :float
	add_column :outcome_analyses, :est_param_adjusted_calc, :boolean
	add_column :outcome_analyses, :disp_adjusted_calc, :boolean
	add_column :outcome_analyses, :ci_perc_adjusted_calc, :boolean
	add_column :outcome_analyses, :lcl_adjusted_calc, :boolean
	add_column :outcome_analyses, :ucl_adjusted_calc, :boolean
	add_column :outcome_analyses, :pvalue_adjusted_calc, :boolean
	add_column :outcome_analyses, :est_param_nonadjusted_calc, :boolean
	add_column :outcome_analyses, :disp_nonadjusted_calc, :boolean
	add_column :outcome_analyses, :ci_perc_nonadjusted_calc, :boolean
	add_column :outcome_analyses, :lcl_nonadjusted_calc, :boolean
	add_column :outcome_analyses, :ucl_nonadjusted_calc, :boolean
	add_column :outcome_analyses, :pvalue_nonadjusted_calc, :boolean
  end

  def self.down
	remove_column :adverse_events, :number
	remove_column :outcome_analyses, :est_param_adjusted_calc
	remove_column :outcome_analyses, :disp_adjusted_calc
	remove_column :outcome_analyses, :ci_perc_adjusted_calc
	remove_column :outcome_analyses, :lcl_adjusted_calc
	remove_column :outcome_analyses, :ucl_adjusted_calc
	remove_column :outcome_analyses, :pvalue_adjusted_calc
	remove_column :outcome_analyses, :est_param_nonadjusted_calc
	remove_column :outcome_analyses, :disp_nonadjusted_calc
	remove_column :outcome_analyses, :ci_perc_nonadjusted_calc
	remove_column :outcome_analyses, :lcl_nonadjusted_calc
	remove_column :outcome_analyses, :ucl_nonadjusted_calc
	remove_column :outcome_analyses, :pvalue_nonadjusted_calc  
  end
end
