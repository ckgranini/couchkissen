class Movie < ActiveRecord::Base
  attr_accessible :tmdb_id, :title, :plot, :poster_id, :trailer_url
  validates :tmdb_id, :title, presence: true, uniqueness: true
  belongs_to :user

  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
