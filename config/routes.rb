Rails.application.routes.draw do
  resources :participants, path: 'paticipantes', except: [:index] do
    member do
      get :certificates_download, action: 'certificates_download'
    end
    collection do
      get :index
      post :import_from_csv
    end
  end
  resources :frequences, path: 'frequencia', except: [:edit, :destroy, :create] do
    collection do
      get :edit
    end
  end
  resources :type_participations, path: 'tipos-participacao'
  resources :certificate_templates, path: 'templates-de-certificados' do
    collection do
      get :load_selected_signatures
    end
    member do
      get 'arquive'
      get 'unarchive'
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
  resources :courses, path: 'cursos'
  resources :events, path: 'eventos' do
    member do
      get 'release_issuing_certificates', action: 'release_issuing_certificates'
    end
  end
  resources :event_categories, path: 'categorias-de-eventos'
  resources :certificate_signatures, path: 'assinaturas-de-certificado' do
    collection do
      get 'autocomplete_by_name_or_role'
    end
    member do
      get 'arquive'
      get 'unarchive'
    end
  end
  resources :permissions, path: 'permissoes', except: [:new, :destroy] do
    collection do
      get 'recreate_and_update_all'
    end
  end
  resources :profiles, path: 'perfis'
  devise_for :users,
             controllers: { omniauth_callbacks: "omniauth_callbacks" },
             :skip => [:registrations]

  resources :users, path: 'usuarios' do
    collection do
      get 'new_registration'
      get 'success_registration'
      post 'registration_save'
    end
  end

# get 'users/:id/complete_registration', to: 'users#complete_registration'

  get 'people/name', to: 'people#name'
  get 'validar/:certificate_hash', to: 'participants#validate_certificate'
  get 'validar/', to: 'participants#validate_certificate'
  get 'people/autocomplete_by_cpf', to: 'people#autocomplete_by_cpf'

  root to: "home#index"

  get '/404', to: "errors#not_found"
  get '/422', to: "errors#unacceptable"
  get '/500', to: "errors#internal_error"
end
