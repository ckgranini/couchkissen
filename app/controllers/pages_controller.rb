class PagesController < ApplicationController
  before_filter :require_login

  def index
    @events = Event.order("datetime").where("datetime >= ?", Time.now.midnight).limit(2)
    @posts = Post.order("created_at DESC").limit(6)
  end
end
