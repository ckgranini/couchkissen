class Event < ActiveRecord::Base
  attr_accessible :title, :datetime, :info
  validates :title, presence:true
  belongs_to :user
  has_many :members
  has_many :posts, as: :postable, dependent: :delete_all
  has_many :users, :through => :members

  self.per_page = 12
end
