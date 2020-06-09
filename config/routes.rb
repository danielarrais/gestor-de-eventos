Rails.application.routes.draw do
  resources :event_requests do
    member do
      get 'forward_the_request', action: 'forward_the_request'
    end
  end
  resources :courses
  resources :events
  resources :event_categories
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

  get 'people/name', to: 'people#name'
  get 'people/autocomplete_by_cpf', to: 'people#autocomplete_by_cpf'

  root to: "home#index"

  get '/404', to: "errors#not_found"
  get '/422', to: "errors#unacceptable"
  get '/500', to: "errors#internal_error"
end
