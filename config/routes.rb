Rails.application.routes.draw do
  root to: 'sequences#index'

  get 'sign_up', to: 'users#new', as: 'sign_up'
  get 'log_in', to: 'sessions#new', as: 'log_in'
  get 'log_out', to: 'sessions#destroy', as: 'log_out'
  get '/auth/github/callback' => 'sessions#create_with_github'
  post '/sequences/:id', to: 'sequences#update'
  patch '/sequences/:sequence_id/poses/:id', to: 'sequences#update'
  patch '/sequences/:sequence_id/poses', to: 'sequences#add_pose', as: 'sequence_add_pose'
  get '/sequences/:sequence_id/pose/:id', to: 'poses#list'

  resources :sequences do
    resources :poses, only: [:index, :new]
    resources :comments, only: [:create]
  end

  resources :users, only: [:create]
  resources :sessions, only: [:create]

end
