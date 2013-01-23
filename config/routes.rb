RailsApp::Application.routes.draw do
  root :to => 'home#index'
  match 'about' => 'home#about'
  match 'builder' => 'builder#index'
  match 'builder/:id' => "builder#show"
  match 'builder/:id/connections' => "builder#connections"
  match 'reader/:id' => "reader#show"
  match 'reader/:id/submission' => "reader#update"

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :users
  resources :sessions

  #resources :charts do
  #  resources :sections do
  #    resources :section_lines
  #  end
  #end
  
  resources :readings
  resources :charts
  resources :tools
  resources :sections 
  resources :section_lines 

end
