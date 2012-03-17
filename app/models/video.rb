class Video < ActiveRecord::Base
  validates :video_url, format: { with: /.*(\d\/|\.be\/|embed\/|[vi][=\/])[-a-zA-Z0-9_]{11,}.*/i }
  belongs_to :user
end
