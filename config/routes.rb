Rails.application.routes.draw do
  root to: 'homepage#index'

  resources :users, except: %i[delete] do
    post :github_scrapper, to: 'users/github_scrapper#create', on: :member
  end
end
