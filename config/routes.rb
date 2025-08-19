Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route - browse available tables/slots
  root "tables#index"

  # Customer-facing routes
  resources :tables, only: [:index]

  resources :time_slots, only: [:index]
  resources :reservations
  # Customer reservations management
  # resources :reservations, only: [:index, :show, :update, :destroy] do
  #   resources :reviews, only: [:new, :create, :update]
  # end

  # Admin namespace for staff management
  namespace :admin do
    root "dashboard#index"

    # Reservations management
    resources :reservations, only: [:index, :show, :update, :destroy]

    # Dashboard and reporting
    # resources :dashboard, only: [:index]

    # Tables management (if needed for future)
    resources :tables do
      resources :time_slots
    end
  end

  # API routes (if needed for AJAX/Stimulus)
  # namespace :api do
  #   namespace :v1 do
  #     resources :time_slots, only: [:index] do
  #       collection do
  #         get :available
  #       end
  #     end
  #     resources :reservations, only: [:create, :update, :destroy]
  #   end
  # end
end
