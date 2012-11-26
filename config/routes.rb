RailsApp::Application.routes.draw do
  root :to => 'home#index'
  match 'about' => 'home#about'
  match 'builder' => 'builder#index'
  match '/builder/:id' => "builder#show"

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :users
  resources :sessions

  resources :charts do
    resources :sections do
      resources :section_lines
    end
  end
  resources :sections 
  resources :section_lines 

end
