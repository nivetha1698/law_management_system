Rails.application.routes.draw do
  devise_for :users

  # get "up" => "rails/health#show", as: :rails_health_check

  # # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

 
  resources :dashboards, only: [:index]
  resources :users
  resources :cases
  resources :clients
  resources :lawyers
  root "dashboards#index"



end
