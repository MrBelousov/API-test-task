Rails.application.routes.draw do
  namespace :api, path: '/' do
    resources :users
    resources :news
  end
end
