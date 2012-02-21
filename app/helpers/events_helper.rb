module EventsHelper
  def exist?(event_id)
    Member.find_by_user_id_and_event_id(current_user.id, event_id)
  end
end
