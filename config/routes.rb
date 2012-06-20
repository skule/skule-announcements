Announcements::Application.routes.draw do

  root :to => "announcements#index"

  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  resources :sessions

  get "signup" => "users#new", :as => "signup"

  resources :users do
    get 'promote', :on => :member
    get 'demote', :on => :member
  end

  resources :password_resets

  resources :announcements do
  	get 'approve', :on => :member
  	get 'reject', :on => :member
  end

end
