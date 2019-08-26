Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  get 'users/:id' => 'users#show'
  root to: "home#index"
end
