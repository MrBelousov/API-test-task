Rails.application.routes.draw do
  namespace :api, path: '/' do
    resources :users do
      resources :news
    end
    resources :news do
      resources :comments
    end
  end
end
