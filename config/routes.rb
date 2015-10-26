Rails.application.routes.draw do
  resources :goals

  resources :users, only: [:new, :create, :show]

  resource :session, only: [:new, :create, :destroy]
end
