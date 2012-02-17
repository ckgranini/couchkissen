class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :phone_home, :mobile, format: {with: /\A([0-9]{3,8})-([0-9]{3,12})\Z/i}, allow_blank: true
  
  before_create {generate_token(:auth_token)}

  has_many :events
  has_many :comments
  has_many :events, :through => :members

  private
  
  def generate_token column
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
    
end
