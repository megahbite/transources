Transources::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  ActiveAdmin.routes(self)
end
