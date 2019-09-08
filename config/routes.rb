Rails.application.routes.draw do
  resources :posts
  resources :relationships, only: [:create, :destroy]

  devise_for :users,
  controllers: { registrations: 'registrations' }, 
  path: '', 
  path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: "home#index"
  get 'users/:nickname' => 'users#show', :as => :user
  get 'users/:nickname/following' => 'users#following'
  get 'users/:nickname/followers' => 'users#followers'
end
