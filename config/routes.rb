Rails.application.routes.draw do

  get 'users/show'
  root to: 'homes#top'
  devise_for :users

  resources :users, only: [:show]
  resources :incomes
  resources :fixedcosts
  resources :variablecosts

end
