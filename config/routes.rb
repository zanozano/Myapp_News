Rails.application.routes.draw do
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}

  resources :articles do
    resources :comments
  end

  resources :comments
  
  authenticated :user do
    root to: 'articles#index', as: :authenticated_root
  end

  root to: 'home#index'
end
