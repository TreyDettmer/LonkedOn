Rails.application.routes.draw do

  resources :education_experiences do
    get 'modify_education_experience', on: :member, defaults: { format: :turbo_stream }
  end

  resources :work_experiences do 
    get 'modify_work_experience', on: :member, defaults: { format: :turbo_stream }
  end
  resources :comments
  resources :companies
  
  get 'profiles/index'
  resources :likes, only: [:create, :destroy]
  resources :applications, only: [:create, :destroy]
  get 'pages/media'
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  resources :users, only: [:show, :edit, :update] do 
    get 'build_a_new_work_experience', on: :member, defaults: { format: :turbo_stream }
    get 'update_about_section', on: :member, defaults: { format: :turbo_stream }
    get 'build_a_new_education_experience', on: :member, defaults: { format: :turbo_stream }
    get 'update_user_profile', on: :member, defaults: { format: :turbo_stream }
  end
  
  post 'users/:id/follow', to: "users#follow", as: "follow"
  post 'users/:id/unfollow', to: "users#unfollow", as: "unfollow"
  post 'users/:id/accept', to: "users#accept", as: "accept"
  post 'users/:id/decline', to: "users#decline", as: "decline"
  post 'users/:id/cancel', to: "users#cancel", as: "cancel"

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/422', to: 'errors#unprocessable'

  resources :social_posts do 
    get 'start_a_comment', on: :member, defaults: { format: :turbo_stream }
    get 'show_comments', on: :member, defaults: { format: :turbo_stream }
    get 'build_a_new_social_post', on: :member, defaults: { format: :turbo_stream }
  end
  resources :job_posts do 
    get 'change_selected', on: :member, defaults: { format: :turbo_stream }
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'pages/media'
  # Defines the root path route ("/")
  root "social_posts#index"
end
