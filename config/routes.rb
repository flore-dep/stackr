Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users

  resource :dashboard, only: :show

  resources :licenses, only: :destroy do
    member do
      patch :accept
      patch :reject
    end
  end

  resources :plans, only: :show do
    resources :licenses, only: :create
  end

  resources :tools, only: %i[index show] do
    resources :plans, only: :create
  end

  resource :organization, only: :show

  resources :teams, only: %i[index show create]

  resources :users, only: %i[index show create update destroy]

  get "up" => "rails/health#show", as: :rails_health_check
end
