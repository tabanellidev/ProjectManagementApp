Rails.application.routes.draw do
  get 'manages/index'
  get 'assignments/index'
  get 'users/index'

  get 'assignments/:id/complete', to: "assignments#complete"
  get 'assignments/:id/uncomplete', to: "assignments#uncomplete" #per testing

  resources :projects
  resources :tasks
  resources :assignments
  resources :manages

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
