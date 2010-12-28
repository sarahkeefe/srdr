Srdr::Application.routes.draw do

  resources :study_templates

  resources :templates

  resources :baseline_characteristic_subcategory_data_points

  resources :baseline_characteristic_data_points

  resources :study_baseline_characteristic_fields

  resources :baseline_characteristic_subcategory_fields

  resources :baseline_characteristic_fields

  resources :user_project_roles

  resources :exclusion_criteria_items

  resources :inclusion_criteria_items

  resources :outcome_results_notes

  resources :publication_numbers

  resources :population_characteristic_subcategories

  get "home/index"

  get "user_sessions/new"

  resources :outcome_timepoint_results
  resources :publications
  resources :population_characteristic_data_points

  resources :key_questions, :arms, :population_characteristics
	
 resources :studies_key_questions

  resources :outcome_enrolled_numbers

  resources :forms

  resources :quality_ratings

  resources :quality_aspects

  resources :adverse_event_arms

  resources :adverse_events

  resources :outcome_analyses

  resources :outcome_results
  resources :outcome_subgroups
  resources :outcome_timepoints
  resources :outcomes
  
  resources :key_questions

  resources :users
  resource :account, :controller => "users"

  resources :studies do
  resources :arms, :population_characteristics
    resources :exclusion_criteria_items

  resources :inclusion_criteria_items
  end
  
  resources :projects do
	resources :studies do
  	resources :arms
	resources :population_characteristics, :publications
	end
	resources :key_questions
end
	match 'projects/:id/studies' => 'studies#index'
	match 'projects/:project_id/studies/:study_id/show_outcome' => 'studies#show_outcome'
	match 'projects/:project_id/studies/:study_id/show_outcome_subgroups_and_timepoints' => 'studies#show_outcome_subgroups_and_timepoints'
	match 'projects/:project_id/studies/:study_id/update_partial' => 'studies#update_partial'
	match 'outcome_analyses/:outcome_analysis_id' => 'outcome_analyses#destroy'
	match 'projects/:project_id/studies/:study_id/clear_table' => 'outcome_results#clear_table'
	match 'projects/:project_id/studies/:study_id/delete_column' => 'outcome_results#delete_column'
	match 'projects/:project_id/moveup' => 'projects#moveup'
	match 'projects/:project_id/studies/:study_id/design' => 'studies#design'
	match 'projects/:project_id/studies/:study_id/attributes' => 'studies#attributes'
	match 'projects/:project_id/studies/:study_id/enrollment' => 'studies#enrollment'
	match 'projects/:project_id/studies/:study_id/outcomesetup' => 'studies#outcomesetup'
	match 'projects/:project_id/studies/:study_id/outcomedata' => 'studies#outcomedata'
	match 'projects/:project_id/studies/:study_id/outcomeanalysis' => 'studies#outcomeanalysis'
	match 'projects/:project_id/studies/:study_id/adverseevents' => 'studies#adverseevents'
	match 'projects/:project_id/studies/:study_id/quality' => 'studies#quality'	
	match 'projects/:project_id/studies/:study_id/adverse_events/savedata' => 'adverse_events#savedata'
	match 'projects/:project_id/manage/saveinfo' => 'user_project_roles#saveinfo'
	match 'projects/:project_id/manage/adduser' => 'user_project_roles#add_new_user'
	match 'templates/:template_id/baseline_characteristics' => 'templates#baseline_characteristics'
	
	match 'publications/:publication_id/moveup' => 'publications#moveup'	
	match 'population_characteristics/:population_characteristic_id/moveup' => 'population_characteristics#moveup'	
	match 'inclusion_criteria_items/:inclusion_criteria_item_id/moveup' => 'inclusion_criteria_items#moveup'	
	match 'exclusion_criteria_items/:exclusion_criteria_item_id/moveup' => 'exclusion_criteria_items#moveup'	
	match 'arms/:arm_id/moveup' => 'arms#moveup'	
	match 'key_questions/:id/moveup' => 'key_questions#moveup'	
	match 'adverse_events/:adverse_event_id/moveup' => 'adverse_events#moveup'	
	match 'quality_aspects/:quality_aspect_id/moveup' => 'quality_aspects#moveup'	
	
	match 'userprojects' => 'users#userprojects'
	match 'projects/:project_id/manage' => 'projects#manage'
	 resources :user_sessions

  match 'search' => 'search#index'
  match 'search/results' => 'search#results'

resources :studies do
	member do 
		get 'design' 
	end 
end 

  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  match 'register' => "users#new", :as => :register
  resources :outcome_column_values

  	resources :outcome_columns

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
	#match 'projects/create' => 'projects#create'
	#match 'projects/new' => 'projects#new'


  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
