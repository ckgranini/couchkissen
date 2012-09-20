class MoviesController < ApplicationController
  before_filter :require_login
  before_filter :check_authorization, only: [:edit, :update, :destroy]

  def index
    @movies = Movie.order("title")
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(params[:movie])
    movie_feed = get_movie_feed(@movie)
    unless movie_feed[0] == "Nothing Found."
      @movie.title = movie_feed["name"]
      @movie.plot = movie_feed["overview"]
      @movie.poster_id = movie_feed["posters"][0]["image"]["url"].match(/(?<=w92\/)(\w*)/).to_s
      @movie.trailer_url = movie_feed["trailer"]
      @movie.tmdb_url = movie_feed["url"] + "?language=de"
      @movie.tmdb_id = movie_feed["id"]
      @movie.imdb_id = movie_feed["imdb_id"]
    end
    @movie.user_id = current_user.id
    if @movie.save
      redirect_to @movie
    else
      render 'new'
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(params[:movie])
      redirect_to movie_path
    else
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      redirect_to movies_path
    end
  end

  private

  def check_authorization
    movie = Movie.find(params[:id])
    unless authorized?(movie.user)
      redirect_to root_path
    end
  end

  def get_movie_feed(movie)
    require 'open-uri'
    begin  
      movie_feed = ActiveSupport::JSON.decode(open("http://api.themoviedb.org/2.1/Movie.getInfo/de/json/APIKEY/" + movie.tmdb_id))[0]
    rescue
      movie_feed = ["Nothing Found."]
    end
  end

end
