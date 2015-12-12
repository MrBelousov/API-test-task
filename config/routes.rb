Rails.application.routes.draw do
  namespace :api, path: '/' do
    # /users
    resources :users do
      # /users/1/news
      resources :news do
        # /users/1/news/1/ratings
        resources :ratings, only: :update
        # /users/1/news/1/comments
        resources :comments do
          # /users/1/news/1/comments/1/ratings
          resources :ratings, only: :update
        end
      end
    end
    # /news
    resources :news do
      # /news/1/ratings
      resources :ratings, only: :update
      # /news/1/comments
      resources :comments do
        # /news/1/comments/1/ratings
        resources :ratings, only: :update
      end
    end

    # Only the update action is required for ratings.
    # /ratings
    resources :ratings, only: :update

    # Root path
    root to: 'news#index'
  end
end
