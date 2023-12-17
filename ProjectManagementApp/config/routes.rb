Rails.application.routes.draw do

  get '/notauthorized', to: 'main#notauthorized'

  get 'assignments/:id/complete', to: "assignments#complete"

  get 'assignments/:id/uncomplete', to: "assignments#uncomplete" #per testing
  get 'assignments/:id/expire', to: "assignments#expire" #per testing

  resources :projects
  resources :tasks
  resources :assignments
  resources :manages

  post 'users', to: "users#create"

  devise_for :users
  resources :users



  #Tasks
  #get 'tasks/index', to: "task#index"
  #get 'tasks/:id', to: "task#show"

  #Projects
  #get '/projects/index', to: "projects#index"
  #get '/projects/new', to: "projects#new"
  #get '/projects/:id', to: "projects#show"


  get "home", to: "home#index"

  get "/", to: "main#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
