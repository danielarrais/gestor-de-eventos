Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]

  resources :users

  root to: "home#index"
end
