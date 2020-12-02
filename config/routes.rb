Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/random', to: "pages#random"
  get '/swipe', to: "pages#swipe"
  get 'user', to: "users#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # error pages
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "errors#show", :code => code
  end
  
  resources :recipes do
    resources :cookbook_recipes, only: [ :create ]
  end

  resources :cookbook_recipes, only: [ :destroy ]
  resources :cookbooks
  resources :grocery_items, only: [ :update ]
  resources :weeks, except: [ :destroy ] do
    member do
      get :today
      get :createlisting
    end
    resources :meals, except: [ :destroy ]
    put '/weeks/:week_id/meals/:id(.:format)/empty', to: "meals#update_empty", as: :empty
    resources :grocery_list, only: [ :show, :update ]
  end
end
