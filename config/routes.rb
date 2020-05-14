Rails.application.routes.draw do
  get 'tweets/index', to: 'tweets#index'

  root 'tweets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
