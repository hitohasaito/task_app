class User < ApplicationRecord
  has_secure_password

  before_validation {email.downcase!}
  validates :user, uniqueness: true
end
