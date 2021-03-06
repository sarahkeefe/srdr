# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110113154558) do

  create_table "adverse_event_arms", :force => true do |t|
    t.integer  "study_id"
    t.integer  "adverse_event_id"
    t.integer  "arm_id"
    t.integer  "num_affected"
    t.integer  "num_at_risk"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adverse_event_columns", :force => true do |t|
    t.string   "header"
    t.string   "name"
    t.string   "description"
    t.integer  "template_id"
    t.integer  "study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adverse_event_results", :force => true do |t|
    t.integer  "column_id"
    t.string   "value"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "adverse_event_id"
  end

  create_table "adverse_events", :force => true do |t|
    t.integer  "study_id"
    t.string   "title"
    t.string   "timeframe"
    t.text     "description"
    t.boolean  "is_serious"
    t.string   "definition_used"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.float    "number"
    t.integer  "display_number"
    t.integer  "arm_id"
    t.integer  "num_affected"
    t.integer  "num_at_risk"
    t.boolean  "is_total"
  end

  create_table "arms", :force => true do |t|
    t.integer  "study_id"
    t.string   "title"
    t.text     "description"
    t.integer  "num_participants"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_number"
  end

  create_table "baseline_characteristic_data_points", :force => true do |t|
    t.integer  "baseline_characteristic_field_id"
    t.integer  "arm_id"
    t.boolean  "is_total"
    t.string   "value"
    t.string   "units"
    t.string   "measurement_type"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "study_id"
  end

  create_table "baseline_characteristic_fields", :force => true do |t|
    t.string   "category_title"
    t.string   "units"
    t.string   "measurement_type"
    t.boolean  "force_measurements"
    t.boolean  "display_arms"
    t.boolean  "display_total"
    t.text     "field_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "template_id"
    t.integer  "study_id"
  end

  create_table "baseline_characteristic_subcategory_data_points", :force => true do |t|
    t.integer  "baseline_characteristic_subcategory_field_id"
    t.integer  "arm_id"
    t.boolean  "is_total"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "baseline_characteristic_subcategory_fields", :force => true do |t|
    t.string   "subcategory_title"
    t.integer  "baseline_characteristic_field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_templates", :force => true do |t|
    t.string   "title"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_adverse_event_columns", :force => true do |t|
    t.string   "header"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_design_details", :force => true do |t|
    t.string   "title"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_outcome_columns", :force => true do |t|
    t.string   "column_name"
    t.text     "column_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "column_header"
    t.string   "outcome_type"
  end

  create_table "default_outcome_comparison_columns", :force => true do |t|
    t.string   "column_name"
    t.string   "column_description"
    t.string   "column_header"
    t.string   "outcome_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "design_detail_data_points", :force => true do |t|
    t.integer  "design_detail_field_id"
    t.string   "value"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "study_id"
  end

  create_table "design_detail_fields", :force => true do |t|
    t.string   "title"
    t.text     "field_notes"
    t.integer  "template_id"
    t.integer  "study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "design_detail_subcategory_data_points", :force => true do |t|
    t.integer  "design_detail_subcategory_field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value"
    t.string   "notes"
    t.integer  "study_id"
  end

  create_table "design_detail_subcategory_fields", :force => true do |t|
    t.string   "subcategory_title"
    t.integer  "design_detail_field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exclusion_criteria_items", :force => true do |t|
    t.integer  "study_id"
    t.string   "item_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_number"
  end

  create_table "footnote_fields", :force => true do |t|
    t.integer  "study_id"
    t.string   "field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "footnote_id"
  end

  create_table "footnotes", :force => true do |t|
    t.integer  "note_number"
    t.integer  "study_id"
    t.string   "note_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "page_name"
    t.string   "data_type"
  end

  create_table "inclusion_criteria_items", :force => true do |t|
    t.integer  "study_id"
    t.string   "item_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_number"
  end

  create_table "key_questions", :force => true do |t|
    t.integer  "project_id"
    t.integer  "question_number"
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcome_analyses", :force => true do |t|
    t.integer  "study_id"
    t.integer  "arm1_id"
    t.integer  "arm2_id"
    t.string   "estimation_parameter_type"
    t.string   "parameter_dispersion_type"
    t.float    "p_value"
    t.string   "adjusted_parameter_dispersion_type"
    t.float    "adjusted_p_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "outcome_id"
    t.string   "adjusted_estimation_parameter_type"
    t.string   "statistical_test"
    t.string   "unadjusted_ci_level"
    t.string   "adjusted_ci_level"
    t.string   "timepoint_comp"
    t.string   "subgroup_comp"
    t.string   "adjusted_for"
    t.float    "unadjusted_ci_lower_limit"
    t.float    "adjusted_ci_lower_limit"
    t.float    "adjusted_ci_upper_limit"
    t.float    "unadjusted_ci_upper_limit"
    t.float    "estimation_parameter_value"
    t.float    "parameter_dispersion_value"
    t.float    "adjusted_estimation_parameter_value"
    t.float    "adjusted_parameter_dispersion_value"
    t.boolean  "est_param_adjusted_calc"
    t.boolean  "disp_adjusted_calc"
    t.boolean  "ci_perc_adjusted_calc"
    t.boolean  "lcl_adjusted_calc"
    t.boolean  "ucl_adjusted_calc"
    t.boolean  "pvalue_adjusted_calc"
    t.boolean  "est_param_nonadjusted_calc"
    t.boolean  "disp_nonadjusted_calc"
    t.boolean  "ci_perc_nonadjusted_calc"
    t.boolean  "lcl_nonadjusted_calc"
    t.boolean  "ucl_nonadjusted_calc"
    t.boolean  "pvalue_nonadjusted_calc"
  end

  create_table "outcome_column_values", :force => true do |t|
    t.integer  "outcome_id"
    t.integer  "timepoint_id"
    t.integer  "subgroup_id"
    t.string   "value"
    t.boolean  "is_calculated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "arm_id"
    t.integer  "column_id"
  end

  create_table "outcome_columns", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "column_header"
    t.string   "outcome_type"
    t.string   "column_name"
    t.string   "column_description"
    t.integer  "template_id"
    t.integer  "study_id"
  end

  create_table "outcome_comparison_columns", :force => true do |t|
    t.string   "column_header"
    t.string   "outcome_type"
    t.string   "column_name"
    t.string   "column_description"
    t.integer  "template_id"
    t.integer  "study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcome_comparisons", :force => true do |t|
    t.integer  "arm_id"
    t.integer  "outcome_id"
    t.integer  "timepoint_id"
    t.integer  "outcome_comparison_column_id"
    t.boolean  "is_calculated"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcome_enrolled_numbers", :force => true do |t|
    t.integer  "arm_id"
    t.integer  "outcome_id"
    t.integer  "num_enrolled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcome_results", :force => true do |t|
    t.integer  "arm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "outcome_id"
    t.integer  "timepoint_id"
    t.integer  "outcome_column_id"
    t.boolean  "is_calculated"
    t.string   "value"
  end

  create_table "outcome_results_notes", :force => true do |t|
    t.integer  "outcome_id"
    t.integer  "timepoint_id"
    t.integer  "subgroup_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcome_subgroups", :force => true do |t|
    t.integer  "outcome_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcome_timepoint_results", :force => true do |t|
    t.integer  "outcome_id"
    t.integer  "study_id"
    t.integer  "arm_id"
    t.integer  "timepoint_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_calculated"
  end

  create_table "outcome_timepoints", :force => true do |t|
    t.integer  "outcome_id"
    t.integer  "number"
    t.string   "time_unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcomes", :force => true do |t|
    t.integer  "study_id"
    t.string   "title"
    t.boolean  "is_primary"
    t.string   "units"
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "outcome_type"
  end

  create_table "primary_publication_numbers", :force => true do |t|
    t.integer  "primary_publication_id"
    t.string   "number"
    t.string   "number_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "primary_publications", :force => true do |t|
    t.integer  "study_id"
    t.string   "title"
    t.string   "author"
    t.string   "country"
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "funding_source"
    t.integer  "creator_id"
  end

  create_table "publication_numbers", :force => true do |t|
    t.integer  "publication_id"
    t.string   "number"
    t.string   "number_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", :force => true do |t|
    t.integer  "study_id"
    t.string   "title"
    t.string   "author"
    t.string   "country"
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "association"
    t.integer  "display_number"
  end

  create_table "quality_aspects", :force => true do |t|
    t.integer  "study_id"
    t.string   "dimension"
    t.string   "value"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_number"
  end

  create_table "quality_dimension_data_points", :force => true do |t|
    t.integer  "quality_dimension_field_id"
    t.string   "value"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "study_id"
    t.string   "field_type"
  end

  create_table "quality_dimension_fields", :force => true do |t|
    t.string   "title"
    t.text     "field_notes"
    t.integer  "template_id"
    t.integer  "study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quality_ratings", :force => true do |t|
    t.integer  "study_id"
    t.string   "guideline_used"
    t.string   "current_overall_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studies", :force => true do |t|
    t.string   "title"
    t.integer  "num_participants"
    t.text     "recruitment_details"
    t.text     "inclusion_criteria"
    t.text     "exclusion_criteria"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.string   "study_type"
    t.integer  "creator_id"
  end

  create_table "studies_key_questions", :force => true do |t|
    t.integer  "study_id"
    t.integer  "key_question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "study_templates", :force => true do |t|
    t.integer  "study_id"
    t.integer  "template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_outcome_columns", :force => true do |t|
    t.integer  "template_id"
    t.integer  "column_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", :force => true do |t|
    t.string   "title"
    t.integer  "creator_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_project_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                             :null => false
    t.string   "email",                             :null => false
    t.string   "fname",                             :null => false
    t.string   "lname",                             :null => false
    t.string   "organization",                      :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

end
