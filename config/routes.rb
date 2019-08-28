Rails.application.routes.draw do
  resources :posts#, only: [:create, :destroy]
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  get 'users/:id' => 'users#show', :as => :user
  root to: "home#index"
end
