Rails.application.routes.draw do
  namespace :api do
    post "session", to: "sessions#create"
    post "dev_login", to: "sessions#dev_login"
    delete "session", to: "sessions#destroy"
    get "me", to: "sessions#me"

    resources :organizations, only: [:index, :show, :create, :update] do
      resources :projects, controller: "projects", only: [:index, :show, :create, :update, :destroy]
      resources :members, controller: "memberships", only: [:index, :create, :update, :destroy]
    end

    resources :isp_sites, only: [:index, :show, :create, :update, :destroy]
    resources :network_assets, only: [:index, :show, :create, :update, :destroy]
    resources :ip_pools, only: [:index, :show, :create, :update, :destroy]
    resources :tickets, only: [:index, :show, :create, :update, :destroy]
    resources :change_requests, only: [:index, :show, :create, :update, :destroy]

    resources :construction_packages, only: [:index, :show, :create, :update, :destroy]
    resources :permits, only: [:index, :show, :create, :update, :destroy]
    resources :procurement_items, only: [:index, :show, :create, :update, :destroy]

    namespace :webhooks do
      post "openproject", to: "openproject#receive"
    end

    namespace :portal do
      resources :projects, only: [:index, :show]
      resources :milestones, only: [:index, :show] do
        post :approve, on: :member
      end
      resources :tickets, only: [:index, :show]
      resources :change_requests, only: [:index, :show] do
        post :approve, on: :member
      end
    end
  end

  get "(*path)", to: "frontend#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end
