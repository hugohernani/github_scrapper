Rails.application.routes.draw do
  root to: 'homepage#index'

  resources :user_registration, only: %i[new create]
end
