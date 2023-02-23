Rails.application.routes.draw do
  devise_for :users
  resources :tracks
  resources :playlists
  resources :my_tracks
  post 'playlists/:id/add_track', to: 'playlists#add_track', as: 'add_track_playlist'
  delete 'playlists/:playlist_id/tracks/:id', to: 'playlists#remove_track', as: 'remove_track_playlist'
  get 'playlists/:playlist_id/tracks/:id', to: 'tracks#show', as: 'playlist_track'
  get '/my_tracks', to: 'tracks#my_tracks', as: 'user_tracks'
  get "/search", to: "trakcs#search"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tracks#index"
end
