require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  
  before :each do
    Movie.create(title: 'test1',director: 'dir1',rating: 'R', release_date: Date.new(2020,10,1))
    Movie.create(title: 'test2',director: 'dir1',rating: 'R', release_date: Date.new(2020,10,1))
    Movie.create(title: 'test3',director: 'dir2',rating: 'R', release_date: Date.new(2020,10,1))
    Movie.create(title: 'test4',director: 'dir2',rating: 'R', release_date: Date.new(2020,10,1))
    Movie.create(title: 'test5',director: 'dir3',rating: 'R', release_date: Date.new(2020,10,1))
    Movie.create(title: 'test6',director: '',rating: 'R', release_date: Date.new(2020,10,1))
    Movie.create(title: 'test7',director: '',rating: 'R', release_date: Date.new(2020,10,1))
    @movies = Movie.all
  end
  
  describe "delete movies" do
    
    context "delete movie 'test1'" do
      
      it "should destroy a movie" do
        movies_count = @movies.count
        movie = Movie.find_by_title("test1")
        
        delete :destroy, id: movie.id 
      
        expect(flash[:notice]).to eq("Movie '#{movie.title}' deleted.")
        expect(response).to redirect_to(movies_path)
        expect(@movies.count).to eq(movies_count-1)
      end
  
    end
  end
  
  describe "create movies" do
    
    context "create movie 'test8'" do
      
      it "should create a movie 'test8'" do
        movies_count = @movies.count
        movie = {title: 'test8', director: 'dir4',rating: 'R', description: 'Movie', release_date: Date.new(2020,10,1)}
        
        post :create, movie: movie
        
        expect(flash[:notice]).to eq("#{movie[:title]} was successfully created.")
        expect(response).to redirect_to(movies_path)
        expect(@movies.count).to eq(movies_count + 1)
      end
  
    end
  end
  
  
  describe "find similar movies" do
    
    context "the specified movie has a director" do
    
      it "should list the similar movies" do
        selected_movie = Movie.find_by_title('test1')
        
        get :find_movies_by_director, id: selected_movie.id
        
        assigns(:similar_movies).each do |movie|
          expect(movie.director).to eq(selected_movie.director)
        end
      end
    end
    
    context "the specified movie has no directors" do
      
      it "should be redirected to the home page with an error message" do
        selected_movie = Movie.find_by_title('test7')
        
        get :find_movies_by_director, id: selected_movie.id
        
        expect(response).to redirect_to('/movies')
        expect(flash[:notice]).to eq("'test7' has no director info")
      end
    end
  end

end
