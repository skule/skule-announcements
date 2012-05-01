Announcements::Application.routes.draw do
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  get "signup" => "users#new", :as => "signup"
  root :to => "announcements#index"

  resources :users
  resources :sessions

  resources :announcements do
  	get 'approve', :on => :member
  	get 'reject', :on => :member
  end
end
