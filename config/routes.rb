Rails.application.routes.draw do

  # Home
  get 'home/top'

  # Users
  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  get "/" => "home#top"
  get "about" => "home#about"
  get "skill" => "home#skill"

  get "photos/index" => "photos#index"
  get "photos/about" => "photos#about"
  get "photos/new" => "photos#new"
  get "photos/:id" => "photos#show"
  get "photos/:id/edit" => "photos#edit"
  post "photos/create" => "photos#create"
  post "photos/:id/destroy" => "photos#destroy"
  post "photos/:id/update" => "photos#update"

  post "likes/:photo_id/create" => "likes#create"
  post "likes/:photo_id/destroy" => "likes#destroy"




  # ?
  get "up" => "rails/health#show", as: :rails_health_check

end
