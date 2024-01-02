Rails.application.routes.draw do

  get '/notauthorized', to: 'main#notauthorized'
  get '/errors', to: 'main#errors'

  get 'assignments/:id/complete', to: "assignments#complete" #per testing
  get 'assignments/:id/uncomplete', to: "assignments#uncomplete" #per testing
  get 'assignments/:id/expire', to: "assignments#expire" #per testing
  get 'assignments/:id/delay', to: "assignments#delay" #per testing

  get 'tasks/:id/complete', to: "tasks#complete" #per testing
  get 'tasks/:id/uncomplete', to: "tasks#uncomplete" #per testing
  get 'tasks/:id/expire', to: "tasks#expire" #per testing
  get 'tasks/:id/delay', to: "tasks#delay" #per testing

  get 'projects/:id/complete', to: "projects#complete" #per testing
  get 'projects/:id/uncomplete', to: "projects#uncomplete" #per testing
  get 'projects/:id/expire', to: "projects#expire" #per testing
  get 'projects/:id/delay', to: "projects#delay" #per testing

  resources :projects
  resources :tasks
  resources :assignments
  resources :manages

  post 'users', to: "users#create"

  devise_for :users, skip: [:registrations]
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
