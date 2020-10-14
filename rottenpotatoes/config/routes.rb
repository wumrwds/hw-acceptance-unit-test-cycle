Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get '/movie/:id/similar_movies' => 'movies#find_movies_by_director', :as => :find_movies_by_director
end
