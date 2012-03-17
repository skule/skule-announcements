Announcements::Application.routes.draw do
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "announcements#index"

  resources :users
  resources :sessions

  resources :announcements
end
