Rails.application.routes.draw do
  get 'index', to: 'countries#index'
  get 'show', to: 'countries#show'

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  put 'complete', to: 'users#complete'
  # get 'logout', to: 'users#logout'

  post 'logout', to: 'expiry#add'

  resources :account_activations, only: [:edit]

  resources :users do
    member do
      get :confirm_email
    end
  end
end
