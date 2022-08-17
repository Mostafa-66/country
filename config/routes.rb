Rails.application.routes.draw do
  resources :countries
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  resources :account_activations, only: [:edit]
  resources :users do
    member do
      get :confirm_email
    end
  end
end
