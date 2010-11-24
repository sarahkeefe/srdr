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

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20101124165350) do
=======
ActiveRecord::Schema.define(:version => 20101124172621) do
>>>>>>> 0fd028632de74c0babf41b9a08ff13a89aae91e3

  create_table "adverse_event_arms", :force => true do |t|
    t.integer  "study_id"
    t.integer  "adverse_event_id"
    t.integer  "arm_id"
    t.integer  "num_affected"
    t.integer  "num_at_risk"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "arms", :force => true do |t|
    t.integer  "study_id"
    t.string   "title"
    t.text     "description"
    t.integer  "num_participants"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "key_questions", :force => true do |t|
    t.integer  "project_id"
    t.integer  "question_number"
    t.string   "question"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcome_analyses", :force => true do |t|
    t.integer  "study_id"
    t.integer  "arm1_id"
    t.integer  "arm2_id"
    t.string   "categorical_or_continuous"
    t.float    "n_analyzed"
    t.float    "n_total"
    t.float    "n_event"
    t.string   "estimation_parameter_type"
    t.string   "estimation_parameter_value"
    t.string   "parameter_dispersion_type"
    t.string   "parameter_dispersion_value"
    t.float    "p_value"
    t.string   "adjusted_parameter_dispersion_type"
    t.string   "adjusted_parameter_dispersion_value"
    t.float    "adjusted_p_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "outcome_id"
    t.string   "adjusted_estimation_parameter_type"
    t.integer  "adjusted_estimation_parameter_value"
    t.integer  "subgroup_id"
    t.string   "statistical_test"
    t.string   "unadjusted_ci_level"
    t.integer  "unadjusted_ci_lower_limit"
    t.integer  "unadjusted_ci_upper_limit"
    t.string   "adjusted_ci_level"
    t.integer  "adjusted_ci_lower_limit"
    t.integer  "adjusted_ci_upper_limit"
    t.integer  "timepoint_id"
  end

  create_table "outcome_column_values", :force => true do |t|
    t.integer  "outcome_id"
    t.integer  "timepoint_id"
    t.integer  "subgroup_id"
    t.string   "value"
    t.boolean  "is_calculated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcome_columns", :force => true do |t|
    t.integer  "outcome_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outcome_enrolled_numbers", :force => true do |t|
    t.integer  "arm_id"
    t.integer  "outcome_id"
    t.integer  "num_enrolled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_total"
  end

  create_table "outcome_results", :force => true do |t|
    t.integer  "study_id"
    t.integer  "arm_id"
    t.integer  "n_analyzed"
    t.string   "measure_type"
    t.string   "measure_value"
    t.string   "measure_dispersion_type"
    t.string   "measure_dispersion_value"
    t.string   "p_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "outcome_id"
    t.boolean  "nanalyzed_is_calculated"
    t.boolean  "measurereg_is_calculated"
    t.boolean  "measuredisp_is_calculated"
    t.boolean  "pvalue_is_calculated"
    t.integer  "timepoint_id"
    t.integer  "subgroup_id"
    t.integer  "column_id"
    t.string   "column_type"
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
    t.integer  "study_id"
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
  end

  create_table "population_characteristic_data_points", :force => true do |t|
    t.integer  "attribute_id"
    t.string   "value"
    t.integer  "arm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_total"
    t.integer  "subcategory_id"
  end

  create_table "population_characteristic_subcategories", :force => true do |t|
    t.string   "subcategory"
    t.string   "units"
    t.integer  "population_characteristic_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "population_characteristics", :force => true do |t|
    t.integer  "study_id"
    t.integer  "arm_id"
    t.string   "category_title"
    t.string   "subcategory"
    t.string   "units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "isbn"
  end

  create_table "publications", :force => true do |t|
    t.integer  "study_id"
    t.string   "title"
    t.string   "author"
    t.string   "country"
    t.string   "year"
    t.string   "ui"
    t.string   "ui_type"
    t.boolean  "is_primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quality_aspects", :force => true do |t|
    t.integer  "study_id"
    t.string   "dimension"
    t.string   "value"
    t.text     "notes"
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
  end

  create_table "studies_key_questions", :force => true do |t|
    t.integer  "study_id"
    t.integer  "key_question_id"
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

end
