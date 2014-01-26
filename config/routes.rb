Transources::Application.routes.draw do

  resources :resources do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
      get 'tag/:tag_id', to: "resources#tag"
    end
  end

  get "tags/categories", to: "tags#categories"

  resources :comments, only: [:destroy] do
    collection do
      get "manage"
    end
  end

  root :to => "home#index"
  devise_for :users
end
