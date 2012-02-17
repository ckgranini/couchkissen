class Post < ActiveRecord::Base
  validates :content, presence:true
  belongs_to :postable, polymorphic: true
  belongs_to :user
end
