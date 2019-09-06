class User < ApplicationRecord
  has_secure_password

  before_validation {email.downcase!}
  validates :email, uniqueness: true

  has_many :tasks
end
