Rails.application.routes.draw do
  resources :profiles
  resources :actions
  devise_for :users, :skip => [:registrations]

  resources :users

  root to: "home#index"
end
