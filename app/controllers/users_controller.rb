class UsersController < ApplicationController
  before_filter :require_login
  before_filter :check_authorization, :only => [:edit, :update, :destroy]

  def index
    @users = User.order("updated_at DESC").where("name <> ?", "admin")
  end

  def show
    params[:id] ||= current_user.id
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path
    else
      render 'edit'
    end
  end


  private

  def check_authorization
    user = User.find(params[:id])
    unless authorized?(user)
      redirect_to root_path
    end
  end

end
