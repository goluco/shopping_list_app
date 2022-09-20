Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  namespace :user_backoffice do
    resources :categories, only: %i[index new create edit update]
    resources :products, only: %i[index new create edit update]
    resources :recipes, only: %i[index new create edit update show] do
      resources :recipe_products, only: %i[new create destroy edit update]
    end
    resources :lists, only: %i[index new create edit update show] do
      resources :list_recipes, only: %i[new create destroy]
    end
  end
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'users/registrations'
      }
    end
  end
end
