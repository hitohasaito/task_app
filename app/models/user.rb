class User < ApplicationRecord
  has_secure_password

  before_destroy :check_admin_user
  before_validation {email.downcase!}

  validates :email, presence: true, uniqueness: true, length: {maximum: 100},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :name, presence: true
  validates :password, presence: true, length: {minimum: 6}

  has_many :tasks, dependent: :destroy

  private

  def check_admin_user
    @admin_user = User.where(admin: "true")
    #binding.pry
    if @admin_user.count == 1
    end
  end
end
