Rails.application.routes.draw do
  get 'tweets/new', to:'tweets#new', as: :new_tweet
  post 'tweets/:id', to:'tweets#create'

  get 'tweets/index', to: 'tweets#index',as: :tweets
  get 'tweets/:id', to: 'tweets#show', as: :tweet
  
  get 'tweets/:id/edit',to: 'tweets#edit',as: :edit_tweet
  patch 'tweets/:id',to: 'tweets#update'

  delete 'tweets/:id',to: 'tweets#destroy'
  root 'tweets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
