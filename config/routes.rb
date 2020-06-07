Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :videos do
    resource :relationships,only: [:create,:destroy]
    collection do
      get 'search'
    end
  end

  root 'videos#index'

  resources :people do
    resources :tags,only: [:create]
    resources :penalties,only: [:create]
  end

  resources :penalties

  resources :tags

  resources :places

  resources :musics
  
end