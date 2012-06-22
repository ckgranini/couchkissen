class Forum < ActiveRecord::Base
  attr_accessible :title
  validates :title, presence:true
  belongs_to :user
  has_many :posts, as: :postable, dependent: :delete_all
end
