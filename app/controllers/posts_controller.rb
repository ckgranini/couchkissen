class PostsController < ApplicationController
  before_filter :check_authorization, :only => [:edit, :update, :destroy]

  def new
    @postable = find_postable
    @post = @postable.posts.new
  end

  def create
    @postable = find_postable
    @post = @postable.posts.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      redirect_to @postable
    else
      render 'new'
    end
  end

  def edit
    @postable = find_postable
    @post = @postable.posts.find(params[:id])
  end

  def update
    @postable = find_postable
    @post = @postable.posts.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @postable
    else
      render 'edit'
    end
  end

  def destroy
    @postable = find_postable
    post = @postable.posts.find(params[:id])
    if post.destroy
      redirect_to @postable
    end
  end


private

  def find_postable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def check_authorization
    @postable = find_postable
    post = @postable.posts.find(params[:id])
    unless authorized?(post.user)
      redirect_to root_path
    end
  end

end
