class Poll < ActiveRecord::Base
  attr_accessible :title, :info, :datetime_end, :selections_attributes
  validates :title, presence:true
  belongs_to :user
  has_many :selections, dependent: :delete_all
  has_many :votes, :through => :selections, dependent: :delete_all
  has_many :posts, as: :postable, dependent: :delete_all

  accepts_nested_attributes_for :selections, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
end
