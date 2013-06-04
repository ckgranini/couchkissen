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
      @movie.title = movie_feed["title"]
      @movie.plot = movie_feed["overview"]
      @movie.poster_id = movie_feed["poster_path"].match(/(?<=\/)(\w*)/).to_s
      unless movie_feed["trailers"]["youtube"].empty?
        @movie.trailer_url = "http://www.youtube.com/watch?v=" + movie_feed["trailers"]["youtube"][0]["source"]
      else
        @movie.trailer_url = ""
      end
      @movie.tmdb_url = "http://www.themoviedb.org/movie/" + movie_feed["id"].to_s + "?language=de"
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
      movie_feed = ActiveSupport::JSON.decode(open("http://api.themoviedb.org/3/movie/" + movie.tmdb_id + "?api_key=APIKEY&language=de&append_to_response=trailers"))
    rescue
      movie_feed = ["Nothing Found."]
    end
  end

end
