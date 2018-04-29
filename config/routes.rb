Rails.application.routes.draw do
  root 'visitors#index'
  resources :scans do
    resources :comparisons
  end
  resources :subdomain_records, only: [:index, :show, :create, :destroy]
  resources :comparisons, only: [:show, :create, :destroy]
end
