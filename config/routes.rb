Rails.application.routes.draw do
  get 'scopes/archive_licenses'
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
    get "archive", to: "scopes#archive_licenses"
  end


  resource :organization, only: :show

  resources :users, only: %i[index show update destroy]

  resources :teams, only: %i[index show create] do
    resources :users, only: %i[create]
  end

  resources :tools, only: %i[index show] do
    resources :plans, only: :create
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
