class Video < ActiveRecord::Base
  attr_accessible :video_url
  validates :video_url, format: { with: /.*(\d\/|\.be\/|embed\/|[vi][=\/])[-a-zA-Z0-9_]{11,}.*/i }
  belongs_to :user

   self.per_page = 4
end
