Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  namespace :user_backoffice do
    resources :categories, only: %i[index new create edit update]
  end
end
