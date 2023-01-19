Rails.application.routes.draw do
  resources :users, only: %i[new register_mail show edit]
end
