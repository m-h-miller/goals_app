Rails.application.routes.draw do
  resources :user_comments
  resources :goals

  resources :users, only: [:new, :create, :show]

  resource :session, only: [:new, :create, :destroy]

  resources :goal_comments, only: [:create, :update, :destroy]

  resources :user_comments, only: [:create, :update, :destroy]
end
