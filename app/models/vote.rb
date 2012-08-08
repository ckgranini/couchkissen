class Vote < ActiveRecord::Base
  attr_accessible :selection_id
  validates :selection_id, presence: true
  validates :user_id, :uniqueness => {:scope => :poll_id}

  belongs_to :selection
  belongs_to :user
end
