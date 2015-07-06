Rails.application.routes.draw do

  resources :mixes
  resources :artists
  resources :genres
  resources :events
  resources :venues

  root 'mixes#index'
end
