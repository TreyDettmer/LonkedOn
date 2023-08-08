Rails.application.routes.draw do
  resources :likes, only: [:create, :destroy]
  get 'pages/media'
  devise_for :users
  resources :social_posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'pages/media'
  # Defines the root path route ("/")
  root "social_posts#index"
end
