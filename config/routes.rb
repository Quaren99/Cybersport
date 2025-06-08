Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get "teams/search" => "teams#search", as: :search_teams
      get "players/search" => "players#search", as: :search_players
      get "tournaments/search" => "tournaments#search", as: :search_tournaments
      resources :tournaments, only: [ :index, :show ]
      resources :teams, only: [ :index, :show ]
      resources :players, only: [ :index, :show ]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
