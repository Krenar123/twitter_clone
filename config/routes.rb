Rails.application.routes.draw do
  resources :tweets do
    resources :retweets
  end

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
