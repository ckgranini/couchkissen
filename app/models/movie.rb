class Movie < ActiveRecord::Base
  validates :tmdb_id, :title, presence: true, uniqueness: true
  belongs_to :user
end
