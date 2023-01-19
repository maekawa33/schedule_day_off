Rails.application.routes.draw do
  get 'user_sessions/new'
  get 'user_sessions/login_mail'
  resources :users, only: %i[new register_mail show edit]
end
