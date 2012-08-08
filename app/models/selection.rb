class Selection < ActiveRecord::Base
  attr_accessible :title
  validates :title, presence:true
  belongs_to :poll
  has_many :votes, dependent: :delete_all
end
