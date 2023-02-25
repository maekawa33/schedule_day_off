Rails.application.routes.draw do
  post 'google_login_api/callback', to: 'google_login_api#callback'
  get 'top', to: 'static_pages#top'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'login', to: 'user_sessions#new'
  get 'login_mail', to: 'user_sessions#login_mail'
  post 'guest_login', to: 'user_sessions#guest_login'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'

  root to: 'static_pages#top'
  resources :users do
    collection do
      get :register_mail
    end
  end
  resources :schedules do
    resource :favorites
    resources :events
  end
end
