Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/random', to: "pages#random"
  get '/swipe', to: "pages#swipe"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes
  resources :cookbooks
  resources :grocery_items, only: [ :update ]
  resources :weeks, except: [ :destroy ] do
    member do
      get :today
    end
    resources :meals, except: [ :destroy, :index ]
  end
end
