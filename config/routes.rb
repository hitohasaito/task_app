Rails.application.routes.draw do
  get 'sessions/new'
  root "tasks#new"
  resources :tasks
  resources :users
  resources :sessions
end
