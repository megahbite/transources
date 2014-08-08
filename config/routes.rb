Transources::Application.routes.draw do

  resources :resources do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'manage'
      get 'search'
      get 'search_all'
      get 'tag/:tag_id', to: "resources#tag"
    end
    member do
      post 'score'
    end
  end

  get "tags/categories", to: "tags#categories"

  resources :comments, only: [:destroy] do
    collection do
      get "manage"
      get 'spam'
      get 'ham'
    end
  end

  resources :banned_ips, only: [:create, :destroy]

  root to: "home#index"

  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'
  get 'privacy', to: 'home#privacy'
  get 'terms', to: 'home#terms'

  devise_for :users
end
