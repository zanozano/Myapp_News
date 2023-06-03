Rails.application.routes.draw do
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}


  resources :comments
  resources :articles

  authenticated :user do
    root to: 'articles#index', as: :authenticated_root
  end

  root to: 'home#index'
end
