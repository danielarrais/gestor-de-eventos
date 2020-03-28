Rails.application.routes.draw do
  resources :certificate_signatures
  resources :permissions, except: [:new, :destroy] do
    collection do
      get 'recreate_and_update_all'
    end
  end
  resources :profiles
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
