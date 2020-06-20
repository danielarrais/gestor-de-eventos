Rails.application.routes.draw do
  resources :frequences, except: [:edit, :destroy, :create] do
    collection do
      get :edit
    end
  end
  resources :type_participations
  resources :certificate_templates do
    collection do
      get :load_selected_signatures
    end
  end
  resources :event_requests, path: 'solicitacoes-eventos' do
    member do
      get 'forward_the_request', action: 'forward_the_request'
      get 'generate_event', action: 'generate_event'
      post 'return_for_changes', action: 'return_for_changes'
    end
    collection do
      get 'my_requests'
    end
  end
  resources :courses
  resources :events
  resources :event_categories
  resources :certificate_signatures do
    collection do
      get 'autocomplete_by_name_or_role'
    end
  end
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
