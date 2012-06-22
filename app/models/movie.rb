class Movie < ActiveRecord::Base
  attr_accessible :tmdb_id
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
