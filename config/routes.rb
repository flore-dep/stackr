Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :licenses, only: :destroy

  resources :plans, only: :show do
    resources :licenses, only: :create
  end

  resources :tools, only: %i[index show] do
    resources :plans, only: :create
  end

  resources :organizations, only: :show

  resources :teams, only: %i[index show create] do
    resources :tools, only: :index
  end

  resources :users, only: %i[index show create update destroy]

  patch 'licenses/:id/accept', to: 'licenses#accept', as: :licenses_accept
  patch 'licenses/:id/reject', to: 'licenses#reject', as: :licenses_reject

end
