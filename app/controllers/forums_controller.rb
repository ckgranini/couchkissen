class ForumsController < ApplicationController
  before_filter :require_login
  before_filter :check_authorization, :only => [:edit, :update, :destroy]

  def index
    @forums = Forum.all(:include => :posts, :order => "posts.created_at DESC")
    redis_del('forums')
  end

  def show
    @forum = Forum.find(params[:id])
    @postable = @forum
    @post = Post.new
    @posts = @forum.posts.paginate(:page => params[:page]).order("created_at DESC")
    redis_rem("forums", @forum.id)
    redis_expire("forum:#{@forum.id}:posts")
  end

  def new
    @forum = Forum.new
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def create
    @forum = Forum.new(params[:forum])
    @forum.user_id = current_user.id
    if @forum.save
      redis_create('forums', @forum.id)
      redirect_to @forum
    else
      render 'new'
    end
  end

  def update
    @forum = Forum.find(params[:id])
    if @forum.update_attributes(params[:forum])
      redirect_to forum_path
    else
      render 'edit'
    end
  end

  def destroy
    @forum = Forum.find(params[:id])
    if @forum.destroy
      redis_del_all("forum:#{@forum.id}:posts")
      redis_rem_all('forums', @forum.id)
      redirect_to forums_path
    end
  end

  private

  def check_authorization
    forum = Forum.find(params[:id])
    unless authorized?(forum.user)
      redirect_to root_path
    end
  end

end
