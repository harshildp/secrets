class User < ActiveRecord::Base
  has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: {minimum: 7, allow_blank:true}

  before_save :lowercase

  private
    def lowercase 
      email.downcase!
    end

end
