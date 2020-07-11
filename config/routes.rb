Rails.application.routes.draw do
  resources :tweets do
    resources :retweets
    resources :likes, only: [ :create]
  end
  
  # Creating these for using .js.erb for displaying likes adn retweets in root_path
  get '/displaylikes/:id', to: 'tweets#display_likes', as: :display_likes
  get '/displayretweets/:id', to: 'tweets#display_retweets', as: :display_retweets

  namespace :auths do
    get '/users/signup', to: 'users#new'
    resources :users, except: :new

    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
  root 'tweets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
