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

  def edit
    @vote = poll.votes.find_by_user_id(current_user.id)
  end

  def update
    @vote = poll.votes.find_by_user_id(current_user.id)
    if @vote.update_attributes(params[:vote])
      redirect_to poll
    else
      render 'edit'
    end
  end

  def destroy
    vote = poll.votes.find_by_user_id(current_user.id)
    unless vote.nil?
      if vote.destroy
        redirect_to poll
      end
    else
      redirect_to poll
    end
  end

  private

  def poll
    @poll ||= Poll.find(params[:poll_id])
  end

end
