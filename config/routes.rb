Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  devise_for :credentials, controllers: { registrations: 'credentials/registrations' }

  resources :quotations
  resources :scans, except: [:update, :edit]
end
