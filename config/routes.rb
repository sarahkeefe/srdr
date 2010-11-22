Srdr::Application.routes.draw do
  resources :population_characteristic_subcategories

  get "home/index"

  get "user_sessions/new"

  resources :outcome_timepoint_results

  resources :population_characteristic_data_points

  	resources :key_questions, :arms, :outcomes, :studies, :population_characteristics
	
  resources :projects do
  	resources :studies, :key_questions
  end
      
  resources :studies do
  	resources :arms, :population_characteristics, :publications, :outcomes
  end
  
  resources :arms do
  	resources :population_characteristics
  end
 
 resources :studies_key_questions

  resources :outcome_enrolled_numbers

  resources :forms

  resources :quality_ratings

  resources :quality_aspects

  resources :adverse_event_arms

  resources :adverse_events

  resources :outcome_analyses

  resources :outcome_results

  resources :outcome_timepoints

  resources :outcomes

  resources :population_characteristics

  resources :publications

  resources :key_questions



  resources :projects do
	resources :studies
end
	match 'projects/:id/studies' => 'studies#index'
	match 'projects/:project_id/studies/:study_id/show_outcome' => 'studies#show_outcome'
	match 'projects/:project_id/moveup' => 'projects#moveup'
	match 'projects/:project_id/studies/:study_id/design' => 'studies#design'
	match 'projects/:project_id/studies/:study_id/attributes' => 'studies#attributes'
	match 'projects/:project_id/studies/:study_id/outcomesetup' => 'studies#outcomesetup'
	match 'projects/:project_id/studies/:study_id/outcomedata' => 'studies#outcomedata'
	match 'projects/:project_id/studies/:study_id/outcomeanalysis' => 'studies#outcomeanalysis'
	match 'projects/:project_id/studies/:study_id/adverseevents' => 'studies#adverseevents'
	match 'projects/:project_id/studies/:study_id/quality' => 'studies#quality'	

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
