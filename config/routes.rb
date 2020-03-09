Rails.application.routes.draw do
  resources :profiles
  resources :actions, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }, :skip => [:registrations]

  resources :users

  root to: "home#index"

  get '/404', to: "errors#not_found"
  get '/422', to: "errors#unacceptable"
  get '/500', to: "errors#internal_error"
end
