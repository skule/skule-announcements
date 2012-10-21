Announcements::Application.routes.draw do

  root :to => "announcements#index"

  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  resources :sessions

  get "signup" => "users#new", :as => "signup"

  resources :users do
    post 'promote', :on => :member
    post 'demote', :on => :member
  end

  resources :password_resets

  resources :announcements do
  	post 'approve', :on => :member
  	post 'reject', :on => :member
  end

end
