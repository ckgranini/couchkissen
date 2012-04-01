class SearchController < ApplicationController
  def movies
    @movies = Movie.search(params[:search])
  end
end
