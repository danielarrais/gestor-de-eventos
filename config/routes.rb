Rails.application.routes.draw do
  resources :actions, except: :new
  resources :profiles
  resources :actions, only: [:index]
  devise_for :users,
             controllers: { omniauth_callbacks: "omniauth_callbacks" },
             :skip => [:registrations]

  resources :users do
    collection do
      get 'new_registration'
      get 'success_registration'
      post 'registration_save'
    end
  end

  # get 'users/:id/complete_registration', to: 'users#complete_registration'

  root to: "home#index"

  get '/404', to: "errors#not_found"
  get '/422', to: "errors#unacceptable"
  get '/500', to: "errors#internal_error"
end
