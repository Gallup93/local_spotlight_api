class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end
end
