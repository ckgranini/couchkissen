class PollsController < ApplicationController
  before_filter :require_login
  before_filter :check_authorization, only: [:edit, :update, :destroy]
  
  def index
    @polls = Poll.all
    redis_expire('polls')
    redis_expire('poll_posts')
  end

  def show
    @poll = Poll.find(params[:id])
    @vote = Vote.new
    @postable = @poll
    @post = Post.new
    @posts = @poll.posts.paginate(:page => params[:page]).order("created_at DESC")
    redis_expire("poll:#{@poll.id}:posts")
  end

  def new
    @poll = Poll.new
    2.times { @poll.selections.build }
  end

  def edit
    @poll = Poll.find(params[:id])
  end

  def create
    @poll = Poll.new(params[:poll])
    @poll.user_id = current_user.id
    if @poll.save
      redis_create('polls', @poll.id)
      redirect_to polls_path
    else
      render 'new'
    end
  end

  def update
    @poll = Poll.find(params[:id])
    if @poll.update_attributes(params[:poll])
      redirect_to poll_path
    else
      render 'edit'
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    if @poll.destroy
      redis_destroy('polls', @poll.id)
      redirect_to polls_path
    end
  end

  private

  def check_authorization
    poll = Poll.find(params[:id])
    unless authorized?(poll.user)
      redirect_to root_path
    end
  end

end
