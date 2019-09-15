Rails.application.routes.draw do
  root "tasks#new"
  resources :tasks
  resources :users
  resources :sessions
end
