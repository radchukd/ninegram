Rails.application.routes.draw do
  resources :posts

  devise_for :users,
  controllers: { registrations: 'registrations' }, 
  path: '', 
  path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: "home#index"
  get 'users/:nickname' => 'users#show', :as => :user
end
