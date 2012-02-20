class PagesController < ApplicationController
  def index
    @events = Event.order("datetime").where("datetime >= ?", Time.now).limit(3)
    @posts = Post.order("created_at DESC").limit(7)
  end
end
