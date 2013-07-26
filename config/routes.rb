Transources::Application.routes.draw do
  resources :resources, except: :index

  root :to => "home#index"
  devise_for :users
  ActiveAdmin.routes(self)
end
