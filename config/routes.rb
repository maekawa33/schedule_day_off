Rails.application.routes.draw do
  get 'top', to: 'static_pages#top'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'login', to: 'user_sessions#new'
  get 'login_mail', to: 'user_sessions#login_mail'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'

  root to: 'static_pages#top'
  resources :users, only: %i[new create show] do
    collection do
      get :register_mail
    end
  end
  resources :schedules, only: %i[new create index]
end
