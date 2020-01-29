Rails.application.routes.draw do
  devise_for :users
  resources :stories
  root to: "home#index"
end
