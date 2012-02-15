module EventsHelper
  def exist?
    Member.find_by_user_id_and_event_id(current_user.id, @event.id)
  end
end
