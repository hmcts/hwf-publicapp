Rails.application.routes.draw do
  if Settings.homepage.external_url
    root to: redirect(Settings.homepage.external_url)
  else
    root 'home#index'
  end

  get 'checklist' => 'home#checklist'

  get 'terms_and_conditions' => 'home#terms_and_conditions'
  get 'accessibility-statement' => 'home#accessibility_statement'

  resources :questions, only: [:edit, :update], path_names: { edit: '' }

  resource :summary, only: :show

  resource :submission, only: :create

  resource :confirmation, only: :show do
    get :done
    get :refund
    get :et
  end

  resource :session, only: :destroy do
    get :start
    post :finish
  end

  resource :help_request, only: %i[new create], path: 'ask-for-help'
  get 'ask-for-help' => 'help_requests#new'

  get 'ping' => 'health_status/ping#show'
  get 'healthcheck' => 'health_status/health_check#show'
end
