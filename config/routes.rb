Rails.application.routes.draw do
  resources :users, except: [:index]
  root 'users#index'

  resource :session, only: [:new, :destroy, :create]
  resources :goals, except: [:index]
end
