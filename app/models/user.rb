class User < ApplicationRecord
  has_secure_password

  before_validation {email.downcase!}
  validates :user, :email, uniqueness: true

  has_many :tasks
end
