class VideosController < ApplicationController
  before_filter :require_login
  before_filter :check_authorization, only: [:edit, :update, :destroy]

  def index
    @videos = Video.order("created_at DESC")
    redis_expire('videos')
  end

  def new
    @video = Video.new
  end

  def edit
    @video = Video.find(params[:id])
  end

  def create
    @video = Video.new(params[:video])
    @video.user_id = current_user.id
    if @video.save
      redis_new('videos', @video.id)
      redirect_to videos_path
    else
      render 'new'
    end
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      redirect_to videos_path
    else
      render 'edit'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    if @video.destroy
      redirect_to videos_path
    end
  end

  private

  def check_authorization
    video = Video.find(params[:id])
    unless authorized?(video.user)
      redirect_to root_path
    end
  end
end
