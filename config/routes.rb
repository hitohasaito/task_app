Rails.application.routes.draw do
  namespace :admin do
    get 'users/new'
    get 'users/edit'
    get 'users/index'
  end
  root "sessions#new"
  resources :tasks
  resources :users
  resources :sessions
end
