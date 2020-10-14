require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MoviesHelper. For example:
#
# describe MoviesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MoviesHelper, type: :helper do
  
  describe "test movie count is odd or even" do
    
    context "given a movie list whose size is 3" do
      before :each do
        Movie.create(title: 'test1',director: 'dir1',rating: 'R', release_date: Date.new(2020,10,1))
        Movie.create(title: 'test2',director: 'dir1',rating: 'R', release_date: Date.new(2020,10,1))
        Movie.create(title: 'test3',director: 'dir2',rating: 'R', release_date: Date.new(2020,10,1))
        @movies = Movie.all
      end
      
      it "should show 'odd'" do
        expect(oddness(@movies.count)).to eq("odd")
      end
  
    end
    
    context "given a movie list whose size is 2" do
      before :each do
        Movie.create(title: 'test1',director: 'dir1',rating: 'R', release_date: Date.new(2020,10,1))
        Movie.create(title: 'test2',director: 'dir1',rating: 'R', release_date: Date.new(2020,10,1))
        @movies = Movie.all
      end
      
      it "should show 'even'" do
        puts @movies.count
        expect(oddness(@movies.count)).to eq("even")
      end
  
    end
  end
end
