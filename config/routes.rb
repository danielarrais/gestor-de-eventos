Rails.application.routes.draw do
  resources :actions
  devise_for :users, :skip => [:registrations]

  resources :users

  root to: "home#index"
end
