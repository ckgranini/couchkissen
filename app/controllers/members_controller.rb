class MembersController < ApplicationController
  before_filter :require_login

  def create
    @member = event.members.new(params[:member])
    @member.user_id = current_user.id
    if @member.save
      redirect_to(event)
    else
      redirect_to(event)
    end
  end

  def destroy
    member = event.members.find_by_user_id(current_user.id)
    if member.destroy
      redirect_to event
    else
      redirect_to event
    end
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end
end
