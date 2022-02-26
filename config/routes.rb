Rails.application.routes.draw do

  root to: 'homes#top'
  devise_for :users

  resources :users, only: [:show, :edit, :update]
  resources :incomes
  resources :fixedcosts
  resources :variablecosts

end
