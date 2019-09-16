Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  root "sessions#new"
  resources :tasks
  resources :users
  resources :sessions
end
