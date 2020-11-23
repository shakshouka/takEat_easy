Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes
  resources :cookbooks
  resources :groceries, except: [ :destroy ]
  resources :weeks, except: [ :destroy ] do
    member do
      get :today
    end
    resources :meals, except: [ :destroy, :index ]
  end
end
