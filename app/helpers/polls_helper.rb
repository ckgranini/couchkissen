module PollsHelper
  def has_voted?(poll_id)
    Vote.find_by_poll_id_and_user_id(poll_id, current_user.id)
  end
end
