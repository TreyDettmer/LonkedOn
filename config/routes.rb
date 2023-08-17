Rails.application.routes.draw do
  resources :comments
  resources :companies
  
  get 'profiles/index'
  resources :likes, only: [:create, :destroy]
  get 'pages/media'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:show]
  
  post 'users/:id/follow', to: "users#follow", as: "follow"
  post 'users/:id/unfollow', to: "users#unfollow", as: "unfollow"
  post 'users/:id/accept', to: "users#accept", as: "accept"
  post 'users/:id/decline', to: "users#decline", as: "decline"
  post 'users/:id/cancel', to: "users#cancel", as: "cancel"

  resources :social_posts do 
    get 'start_a_comment', on: :member, defaults: { format: :turbo_stream }
    get 'show_comments', on: :member, defaults: { format: :turbo_stream }
  end
  resources :job_posts do 
    get 'change_selected', on: :member, defaults: { format: :turbo_stream }
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'pages/media'
  # Defines the root path route ("/")
  root "social_posts#index"
end
