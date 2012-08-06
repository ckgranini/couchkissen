class EventsController < ApplicationController
  before_filter :require_login
  before_filter :check_authorization, only: [:edit, :update, :destroy]

  def index
    @events = Event.where("datetime > ?", Time.now.midnight).order("datetime")
  end

  def show
    @event = Event.find(params[:id])
    @postable = @event
    @post = Post.new
    @posts = @event.posts.paginate(:page => params[:page]).order("created_at DESC")
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user.id
    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to event_path
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to events_path
    end
  end

  def archive
    @events = Event.paginate(:page => params[:page]).order("datetime DESC")
  end

  private

  def check_authorization
    event = Event.find(params[:id])
    unless authorized?(event.user)
      redirect_to root_path
    end
  end

end
