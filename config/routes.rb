Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  namespace :user_backoffice do
    resources :categories, only: %i[index new create edit update]
    resources :products, only: %i[index new create edit update]
    resources :recipes, only: %i[index new create edit update show] do
      resources :recipe_products, only: %i[new create]
    end
    resources :lists, only: %i[index new create edit update show]
  end
end
