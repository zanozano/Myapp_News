Rails.application.routes.draw do
  resources :comments
  resources :articles
  devise_for :users
  #root "home#index"
end
