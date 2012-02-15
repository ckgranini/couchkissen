class Event < ActiveRecord::Base
  belongs_to :user
  has_many :members
  has_many :posts, as: :postable 
  has_many :users, :through => :members
end
