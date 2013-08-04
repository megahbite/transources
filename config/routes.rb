Transources::Application.routes.draw do

  resources :resources, except: :index do
    resources :comments, only: [:create, :destroy]
  end

  root :to => "home#index"
  devise_for :users
  ActiveAdmin.routes(self)
end
