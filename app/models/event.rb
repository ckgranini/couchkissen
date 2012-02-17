class Event < ActiveRecord::Base
  validates :title, presence:true
  belongs_to :user
  has_many :members
  has_many :posts, as: :postable 
  has_many :users, :through => :members
end
