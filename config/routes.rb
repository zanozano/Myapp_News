Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }


  resources :comments
  resources :articles

  get "home/index"
  root "home#index"
end
