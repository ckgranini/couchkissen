class VotesController < ApplicationController
  before_filter :require_login

  def create
    @vote = poll.votes.new(params[:vote])
    @vote.user_id = current_user.id
    @vote.poll_id = poll.id
    if @vote.save
      redirect_to poll
    else
      redirect_to poll
    end
  end

  private

  def poll
    @poll ||= Poll.find(params[:poll_id])
  end

end
