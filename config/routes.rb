Rails.application.routes.draw do

  get 'static_pages/index'

  #get 'newdeposit', to: 'users#newdeposit'
  
  post 'users/addmoney'
  
  devise_for :users
  resources :users, only: [:index, :show]


  root 'static_pages#index'

  #get 'users/profile', as: 'user_root'

  resources :predictions, only: [:index, :new, :create, :destroy]
  resources :subscriptions, only: [:index, :new, :create, :destroy]

  get 'statistic', to: 'predictions#statistic'
  get 'predictions/:id', to: 'predictions#purchase'
  get 'predictions/:id/accept', to: 'predictions#accept'
  get 'predictions/:id/decline', to: 'predictions#decline'
  get 'subscriptions/:id', to: 'subscriptions#purchase'

  get 'cpvls', to: 'users#panel'

  get 'faq', to: 'static_pages#faq'
  get 'contact', to: 'static_pages#contact'

end
