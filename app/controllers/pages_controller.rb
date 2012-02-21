class PagesController < ApplicationController
  before_filter :require_login

  def index
    @events = Event.order("datetime").where("datetime >= ?", Time.now.midnight).limit(3)
    @posts = Post.order("created_at DESC").limit(7)
  end
end
