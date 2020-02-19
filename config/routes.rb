Rails.application.routes.draw do
  root to: 'users#index'
  resources :users do
    resources :friends, controller: :contacts, type: 'Friend'
    resources :emergencies, controller: :contacts, type: 'Emergency'
  end
end
