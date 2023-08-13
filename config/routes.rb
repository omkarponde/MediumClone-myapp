Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resource :profile, only: [:show, :update, :create]
  resources :profiles, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  post '/post', to: 'posts#create'
  put '/post', to: 'posts#update'
  delete '/post', to: 'posts#delete'
  get '/post', to: 'posts#index'
  get '/myposts', to:'posts#show'
  get '/filter_by_user', to: 'posts#filter_by_user'
  get '/filter_by_time_range', to: 'posts#filter_by_time_range'


  post '/follow', to:'followers#follow'
  delete '/unfollow', to:'followers#unfollow'

  get '/recommended_posts', to:'posts#recommended_posts'
  get '/top_posts', to:'posts#top_posts'
  get '/topics', to:'topics#topics'

  post '/save_post', to:'posts#save_post'
  delete '/save_post', to:'posts#unsave_post'
  get '/save_post', to:'posts#saved_posts'


  get '/draft', to:'posts#my_drafts'
  post '/draft', to:'posts#create_draft'
  put '/draft', to:'posts#update_draft'
  delete '/draft', to:'posts#delete_draft'
  put '/publish', to:'posts#publish'

  get '/revisions', to:'posts#revision_history'


  post '/create_payment', to: 'payments#create_payment'
  post '/webhook', to: 'payments#webhook'


  post '/playlist', to: 'playlists#create'
  get '/playlist', to: 'playlists#show'
  put '/add_post', to: 'playlists#add_post'
  delete '/remove_post', to: 'playlists#remove_post'
  post '/share_post', to: 'playlists#share'

end
