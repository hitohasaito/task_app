class User < ApplicationRecord
  has_secure_password

  before_validation {email.downcase!}
  validates :email, presence: true, uniqueness: true, length: {maximum: 100}
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :name, presence: true
  validates :password, presence: true, length: {minimun: 6}

  has_many :tasks
end
