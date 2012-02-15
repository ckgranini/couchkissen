class Member < ActiveRecord::Base
  validates :user_id, :uniqueness => { :scope => :event_id }

  belongs_to :event
  belongs_to :user
end
