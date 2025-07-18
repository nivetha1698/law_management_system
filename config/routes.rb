Rails.application.routes.draw do
  devise_for :users

  resources :dashboards, only: [ :index ]
  resources :users do
    member do
      patch :upload
      delete :remove
    end
  end

  resources :clients do
    member do
      get :cases
    end
  end

  resources :court_cases do
    member do
      get :lawyers
    end
  end

  resources :lawyers
  resources :judges
  resources :tasks
  resources :roles
  resources :categories
  resources :appointments
  resources :services
  resources :invoices do
    get :get_issued_user, on: :collection
    member do
     get :download, defaults: { format: "pdf" }
    end
  end

  get "/profile", to: "users#show_current", as: :profile
  get "invoices/new_item_field", to: "invoices#new_item_field"
  get "/services/:id/price", to: "services#price"
  root "dashboards#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
