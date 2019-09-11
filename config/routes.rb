Rails.application.routes.draw do
  resources :posts do
    member do
      put 'like' => 'posts#vote'
    end
  end
  
  resources :relationships, only: [:create, :destroy]

  devise_for :users,
  controllers: { registrations: 'registrations' }, 
  path: '', 
  path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: 'feed#index'
  match 'users/:nickname' => 'users#show', 
        :constraints => { :nickname => /[0-9A-Za-z\-\.\_]+/ },
        :via => [:get],
        :as => :user
  get 'users/:nickname/following' => 'users#following'
  get 'users/:nickname/followers' => 'users#followers'
  get 'discover' => 'users#discover'
  get 'activity' => 'users#activity'
  get 'search'   => 'users#search'
end
