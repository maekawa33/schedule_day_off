Rails.application.routes.draw do
  get 'login', to: 'user_sessions#new'
  get 'login_mail', to: 'user_sessions#login_mail'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create show] do
    collection do
      get :register_mail
    end
  end
end
